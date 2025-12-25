{
  imports = [
    ./hardware-configuration.nix

    ../../config/core.nix
    ../../config/zram.nix
    ../../config/zsh.nix
  ];

  services.tailscale.extraSetFlags = [ "--advertise-exit-node" ];

  time.timeZone = "Asia/Dubai";
}
