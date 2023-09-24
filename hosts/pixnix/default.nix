{ pkgs, inputs, ... }: {
  imports = [
    inputs.hardware.nixosModules.common-cpu-intel
    inputs.hardware.nixosModules.common-pc-ssd

    ./hardware-configuration.nix
    ./services

    ../common/global
    ../common/users/john

    ../common/optional/docker.nix
  ];

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  networking = {
    hostName = "pixnix";
    # wireless.enable = true;
    networkmanager.enable = true;
  };

  time.timeZone = "America/Chicago";

  system.stateVersion = "23.05";

}
