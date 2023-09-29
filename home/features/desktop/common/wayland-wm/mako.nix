{ config, ... }: {
  services.mako = {
    enable = true;
    font = "${config.fontProfiles.regular.family} 12";
    padding = "10,20";
    anchor = "top-center";
    width = 400;
    height = 150;
    borderSize = 2;
    defaultTimeout = 12000;
    layer = "overlay";
  };
}
