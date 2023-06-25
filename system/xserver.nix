{
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "getpsyched";

      lightdm.enable = true;
      defaultSession = "none+i3";
    };
    windowManager.i3.enable = true;
  };
}
