{
  services = {
    xserver = {
      enable = true;
      displayManager = {
        gdm = {
          enable = true;
          autoSuspend = false;
        };
      };
      desktopManager = {
        gnome.enable = true;
      };
      layout = "us";
      xkbVariant = "";
    };
    geoclue2.enable = true;
  };
}