{
  imports = [
    ./hardware-configuration.nix

    ../../config/user.nix
    ../../config/hardware.nix
    ../../config/nix.nix
    ../../config/tailscale.nix
    ../../config/zram.nix
  ];

  services.tailscale.extraSetFlags = [ "--advertise-exit-node" ];

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "24.11";
}
