{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    inputs.hyprland.homeManagerModules.default
    ./global
    ./features/cli/extras
    ./features/desktop
    ./features/desktop/hyprland
  ];

  # packages
  home.packages = with pkgs; [
    vagrant
  ];
}
