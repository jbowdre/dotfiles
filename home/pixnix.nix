{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./global
    ./features/cli/extras
    ./features/desktop
    ./features/desktop/hyprland
  ];

  # packages
  home.packages = with pkgs; [
    vagrant
  ];

  monitors = [{
    name = "eDP-1";
    width = 2400;
    height = 1600;
    workspace = "1";
    primary = true;
  }];
}
