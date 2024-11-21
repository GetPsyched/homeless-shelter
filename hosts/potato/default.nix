{
  imports = [
    ./hardware-configuration.nix

    ../../system/user.nix
    ../../system/hardware.nix
    ../../system/nix.nix
    ../../system/tailscale.nix
    ../../system/zram.nix
  ];

  services.tailscale.extraSetFlags = [ "--advertise-exit-node" ];

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "24.11";
}
