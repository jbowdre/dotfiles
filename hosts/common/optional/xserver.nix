{
  services = {
    xserver = {
      enable = true;
      displayManager.gdm = {
        enable = true;
        autoSuspend = false;
      };
    };
    logind.lidSwitch = "ignore";
  };
}