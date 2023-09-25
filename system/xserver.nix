{
  services.xserver = {
    enable = true;
    layout = "us";

    libinput.touchpad.naturalScrolling = true;

    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "getpsyched";

      lightdm.enable = true;
      defaultSession = "none+i3";
    };
    windowManager.i3.enable = true;
  };
}
