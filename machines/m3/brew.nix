{ pkgs, ... }: {

  home-manager.users.nico.home.sessionPath = [
    "/opt/homebrew"
  ];
  
  homebrew = {
    enable = false;
    brews = [
      "cockroachdb/tap/cockroach"
    ];
    taps = [
      {
        name = "cockraochdb/tap";
        clone_target = "git@github.com:cockroachdb/homebrew-tap.git";
      }
    ];
  };
}
