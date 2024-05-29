{
  imports = [
    ../../users/getpsyched

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/pipewire.nix
    ../common/optional/warp.nix
    ../common/optional/plasma.nix
    ../common/optional/zram.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "24.11";
}
