{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [ ../modules/tui inputs.catppuccin.homeManagerModules.catppuccin ]
    ++ (builtins.attrValues outputs.homeManagerModules);

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
      experimental-features = [ "nix-command" "flakes" ];
      warn-dirty = false;
    };
  };

  home = {
    username = lib.mkDefault "john";
    homeDirectory = lib.mkDefault "/home/${config.home.username}";
    stateVersion = lib.mkDefault "24.11";

    sessionVariables = { EDITOR = "nvim"; };
  };

  programs = {
    home-manager.enable = true;

  };

  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  targets.genericLinux.enable = true;
}
