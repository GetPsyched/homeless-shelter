{
  hostName,
  inputs,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../config/core.nix
    ../../config/dconf.nix
    ../../config/direnv.nix
    ../../config/firefox.nix
    ../../config/flameshot.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/i3.nix
    ../../config/kitty.nix
    ../../config/locale.nix
    ../../config/networking.nix
    ../../config/yubikey.nix
    ../../config/zsh.nix
  ];

  image.modules.iso-installer = {
    image.baseName = lib.mkForce hostName;
    isoImage = {
      configurationName = hostName;
      volumeID = hostName;
    };

    age.secrets.tailscale.file = lib.mkForce "${inputs.self}/secrets/tailscale-ephemeral.age";

    environment.systemPackages = [ pkgs.gparted ];
    users.users.primary.packages = [ pkgs.wifi-qr ];

    networking.wireless.enable = lib.mkForce false;

    # Remove broken zfs backage from the base ISO config
    boot.zfs.forceImportRoot = false;
  };
}
