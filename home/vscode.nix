{ config, lib, pkgs, ... }:

{
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

    userSettings = {
      "[nix]"."editor.tabSize" = 2;
      "workbench.colorTheme" = "Default Dark Modern";
      "update.mode" = "none";
      "files.autoSave" = "onFocusChange";
    };

  };
}
