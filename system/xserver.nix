{
  services.xserver = {
    enable = true;
    layout = "us";

    displayManager = {
      autoLogin.enable = true;
      autoLogin.user = "getpsyched";

      lightdm.enable = false;
    };
  };
}
