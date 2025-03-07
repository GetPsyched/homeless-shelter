{ hostName, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.starfive-visionfive-2

    ./hardware-configuration.nix

    ../../config/core.nix
  ];

  networking.hostName = hostName;
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

  time.timeZone = "Asia/Bangkok";
}
