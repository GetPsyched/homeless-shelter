{ lib, ... }:
{
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/44444444-4444-4444-8888-888888888888";
    fsType = "ext4";
  };

  nixpkgs.buildPlatform = lib.mkDefault "x86_64-linux";
  nixpkgs.hostPlatform = lib.mkDefault "riscv64-linux";
}
