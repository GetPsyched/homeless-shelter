{ config, pkgs, ... }:
{
  users.users.${config.mainuser}.extraGroups = [ "dialout" ];
  environment.systemPackages = with pkgs; [
    # FIXME: Cache miss for qt6.full
    # (python311Packages.callPackage ../packages/nexus.nix {
    #   pyside6-essentials = (python311Packages.callPackage ../packages/pyside6-essentials.nix { });
    # })
  ];
}
