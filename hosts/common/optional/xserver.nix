{
  services.xserver = {
    enable = true;
    xkb.layout = "us";

    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };
}
