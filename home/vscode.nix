{ config, lib, pkgs, ... }:

{
  # for use within config
  home.packages = [ pkgs.nil pkgs.nixpkgs-fmt pkgs.terraform ];

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      jnoortheen.nix-ide
      hashicorp.terraform
    ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
      {
        name = "HCL";
        publisher = "HashiCorp";
        version = "0.3.2";
        sha256 = "sha256-cxF3knYY29PvT3rkRS8SGxMn9vzt56wwBXpk2PqO0mo=";
      }
    ]
    ;

    # be not afraid - this is JSON as a nix object, and corresponds to VSCode's settings.json
    # you can override it by setting `programs.vscode.userSettings.[setting] = lib.mkForce {}` yourself.
    userSettings = {
      "workbench.colorTheme" = "Default Dark Modern";
      "update.mode" = "none";
      "files.autoSave" = "onFocusChange";
      "editor.fontFamily" = "Fira Code Nerd Font, Menlo, Monaco, 'Courier New', monospace";

      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "nixpkgs-fmt";

      # settings for 'nil' LSP
      "nix.serverSettings"."nil"."formatting"."command" = [ "nixpkgs-fmt" ];
      "python.envFile" = "\${workspaceRoot}/.env";
      "python.linting.flake8Enabled" = true;
      "python.linting.pylintEnabled" = false;
      "python.linting.mypyEnabled" = true;
      "[nix]" = {
        "editor.insertSpaces" = true;
        "editor.tabSize" = 2;
      };
      "[hcl]" = {
        "editor.defaultFormatter" = "Vehmloewff.custom-format";
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";
      };
      "[terraform-vars]" = {
        "editor.defaultFormatter" = "hashicorp.terraform";
        "editor.formatOnSave" = true;
        "editor.formatOnSaveMode" = "file";
      };
      "files.associations"."*.nomad" = "hashicorp.hcl";
      "vim.normalModeKeyBindingsNonRecursive" = [
        {
          # vim: gf -> format
          "before" = [ "g" "f" ];
          "when" = "editorHasDocumentFormattingProvider && editorTextFocus && !editorReadonly && !inCompositeEditor";
          "commands" = [ "editor.action.formatDocument" ];
        }
      ];
      "window.menuBarVisibility" = "hidden";
      "window.titleBarStyle" = "custom";
      "explorer.confirmDelete" = false;
      "workbench.editor.empty.hint" = "hidden";
    };
  };
}
