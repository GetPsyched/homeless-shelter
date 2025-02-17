{ config, pkgs, ... }:
{
  users.users.primary.extraGroups = [ "dialout" ];
  # environment.systemPackages = with pkgs; [ cc-nexus ];
}
