{ inputs, outputs, lib, config, pkgs, ... }: {
  imports = [
    ./global
    ./features/cli/extras
    ./features/desktop
    ./features/desktop/hyprland.nix
  ];

  # packages
  home.packages = with pkgs; [
    kitty
    vagrant
  ];
}
