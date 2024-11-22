{ config, pkgs, ... }:
{
  users.users.${config.mainuser}.extraGroups = [ "dialout" ];
  environment.systemPackages = with pkgs; [
    (python311Packages.callPackage ../packages/nexus.nix {
      pyside6-essentials = (python311Packages.callPackage ../packages/pyside6-essentials.nix { });
    })
  ];
}
