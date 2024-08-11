{
  imports = [
    ../../users/getpsyched

    ../common/core
    ./hardware-configuration.nix

    ../common/optional/tailscale
    ../common/optional/dconf.nix
    ../common/optional/i3.nix
    ../common/optional/nvidia.nix
    ../common/optional/pipewire.nix
    ../common/optional/steam.nix
    ../common/optional/virtualisation.nix
    ../common/optional/warp.nix
    ../common/optional/zram.nix
  ];

  # Enable CUPS to print documents.
  services.printing.enable = true;

  persist.enable = true;
  persist.sysDataDirs = [ "/var/lib/libvirt" ];
  persist.sysDataFiles = [ "/var/lib/prince/license.dat" ];

  # Overlay broken?
  # see https://discourse.nixos.org/t/nixos-rebuild-fails-on-a-weird-error-after-bumping-nixpkgs
  # nixpkgs.overlays = [ (import ../../overlays/i3.nix) ];

  system.stateVersion = "22.11";
}
