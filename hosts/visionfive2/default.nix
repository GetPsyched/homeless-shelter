{
  config,
  hostName,
  inputs,
  ...
}:
{
  imports = [
    inputs.nixos-hardware.nixosModules.starfive-visionfive-2

    ./hardware-configuration.nix

    ../../config/builders.nix
    ../../config/nix.nix
    ../../config/user.nix
  ];

  # FIXME: this doesn't cross compile
  home-manager.users.${config.mainuser}.xdg.mime.enable = false;

  networking.hostName = hostName;
  networking.hostId = builtins.substring 0 8 (builtins.hashString "md5" hostName);

  # sshd.service got killed once, I'm not taking chances
  services.openssh.enable = true;

  time.timeZone = "Asia/Bangkok";
  system.stateVersion = "25.05";
}
