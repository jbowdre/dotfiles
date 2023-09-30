{ config, inputs, pkgs, ... }: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemdIntegration = true;
    extraConfig = ''
      # hyprland config goes here
    '';
  };
}
