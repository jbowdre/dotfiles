{ config, pkgs, inputs, ... }: {
  gtk = {
    enable = true;
  };

  services.xsettingsd = {
    enable = true;
  };
}
