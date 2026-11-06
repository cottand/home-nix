{ config, lib, pkgs, ... }: {
  programs.git = {
    signing.format = "openpgp";
    enable = true;
    settings.user.name = "cottand";
    settings.user.email = "nico.dc@outlook.com";
    settings.alias = {
      ac = "!git add . && git commit -m";
      co = "checkout";
      s = "status";
      ps = "push";
      pl = "pull";
      d = "diff";
      f = "fetch";
      st = "stash";
      sp = "stash pop";
      br = "branch";
      yolo = "commit --amend -a --no-edit";
    };

    # large monorepo config

    settings.fetch.prune = true;
    feature.manyFiles = true;
    commitGraph.changedPathsVersion = 2; # 1st time run: git commit-graph write --reachable --changed-paths --split=replace
  };


}