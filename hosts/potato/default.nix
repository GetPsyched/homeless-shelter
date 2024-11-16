{
  imports = [
    ../../users/getpsyched

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/zram.nix
  ];

  services.openssh.enable = true;

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "24.11";
}
