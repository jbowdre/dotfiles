{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ../features/cli
  ] ++ (builtins.attrValues outputs.homeManagerModules);

  nixpkgs = {
    overlays = builtins.attrValues outputs.overlays;
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

  nix = {
    package = lib.mkDefault pkgs.nix;
    settings = {
      experimental-features = ["nix-command" "flakes" "repl-flake" ];
      warn-dirty = false;
    };
  };

  home = {
    username = lib.mkDefault "john";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "23.05";

    sessionVariables = {
      EDITOR = "vim";
    };
  };

  programs = {
    home-manager.enable = true;

    direnv = {
      enable = lib.mkDefault true;
      nix-direnv.enable = true;
    };

    git = {
      enable = lib.mkDefault true;
      delta.enable = true;
      userEmail = lib.mkDefault "john@bowdre.net";
      userName = lib.mkDefault "John Bowdre";
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = false;
      };
    };

  };

  targets.genericLinux.enable = true;
}
