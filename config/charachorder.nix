{ config, pkgs, ... }:
{
  users.users.${config.mainuser}.extraGroups = [ "dialout" ];
  # environment.systemPackages = with pkgs; [ cc-nexus ];
}
