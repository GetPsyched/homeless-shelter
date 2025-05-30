{
  imports = [
    ./hardware-configuration.nix

    ../../config/bash.nix
    ../../config/boot.nix
    ../../config/core.nix
    ../../config/home.nix
    ../../config/zram.nix
  ];

  services.tailscale.extraSetFlags = [ "--advertise-exit-node" ];

  time.timeZone = "Asia/Dubai";
}
