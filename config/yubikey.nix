{ lib, pkgs, ... }:
{
  age = {
    ageBin = "PATH=$PATH:${lib.makeBinPath [ pkgs.age-plugin-yubikey ]} ${lib.getExe pkgs.age}";
    identityPaths = [ ../yubisneeze-1.txt ];
  };

  environment.systemPackages = with pkgs; [ yubikey-manager ];

  services.pcscd.enable = true;
}
