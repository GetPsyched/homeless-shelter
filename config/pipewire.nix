{
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };
  services.pulseaudio.enable = false;
  persist.state.homeDirectories = [ ".local/state/wireplumber" ];
}
