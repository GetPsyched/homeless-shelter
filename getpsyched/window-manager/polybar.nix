{
  services = {
    polybar = {
      enable = true;
      config = ./polybar.ini;
      script = "polybar bar &";
    };
  };
}
