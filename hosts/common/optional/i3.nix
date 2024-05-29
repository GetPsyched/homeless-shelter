{
  services.displayManager = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = "getpsyched";
    defaultSession = "none+i3";
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };
}
