{ hostName, inputs, ... }:
{
  imports = [
    inputs.nixos-hardware.nixosModules.starfive-visionfive-2

    ./hardware-configuration.nix

    ../../config/builders.nix
    ../../config/core.nix
    ../../config/nix.nix
    ../../config/tailscale.nix
    ../../config/user.nix
  ];

  networking.hostName = hostName;
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

  # sshd.service got killed once, I'm not taking chances
  services.openssh.enable = true;

  time.timeZone = "Asia/Bangkok";
}
