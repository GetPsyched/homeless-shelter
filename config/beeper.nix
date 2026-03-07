{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs; [ beeper ];
  nixpkgs.config.allowUnfreePackages = [ "beeper" ];
  persist.data.homeDirectories = [ ".config/BeeperTexts" ];
}
