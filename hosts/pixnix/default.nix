{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix

    ../common/global
    ../common/users/john

    ../common/optional/docker.nix
    ../common/optional/greetd.nix
    ../common/optional/hyprland.nix
    ../common/optional/libvirtd.nix
    ../common/optional/pipewire.nix
    ../common/optional/printing.nix
    ../common/optional/sshd.nix
  ];

  networking = {
    hostName = "pixnix";
    networkmanager.enable = true;
  };

  xdg.portal = {
    enable = true;
    wlr.enable = true;
  };

  system.stateVersion = "23.05";

}
