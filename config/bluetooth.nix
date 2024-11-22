{
  services.blueman.enable = true;
  hardware.bluetooth = {
    enable = true;
    settings = {
      General = {
        Experimental = true;
      };
    };
  };

  persist.state.directories = [ "/var/lib/bluetooth" ];
}
