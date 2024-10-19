{
  imports = [
    ../../users/getpsyched
    ../../users/guest

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/networking.nix
    ../common/optional/pipewire.nix
    ../common/optional/warp.nix
    ../common/optional/plasma.nix
    ../common/optional/tailscale/minecraft.nix
    ../common/optional/zram.nix
  ];

  services.openssh.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  time.timeZone = "Asia/Dubai";
  system.stateVersion = "24.11";
}
