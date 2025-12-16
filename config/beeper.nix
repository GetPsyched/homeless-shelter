{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [ beeper ];
  allowUnfreePackages = [ "beeper" ];
  persist.data.homeDirectories = [ ".config/BeeperTexts" ];
}
