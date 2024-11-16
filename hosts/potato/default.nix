{
  imports = [
    ../../users/getpsyched

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/zram.nix
  ];

  services.tailscale.extraSetFlags = [ "--advertise-exit-node" ];

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "24.11";
}
