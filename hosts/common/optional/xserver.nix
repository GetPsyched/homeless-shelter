{
  services.xserver = {
    enable = true;
    xkb.layout = "us";

    libinput.touchpad.naturalScrolling = true;

    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };
}
