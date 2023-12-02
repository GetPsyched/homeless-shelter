{ pkgs, ... }:
let
  ff-addons = import ./addons.nix { inherit pkgs; };
  profiles.main = import ./profile-main { inherit ff-addons pkgs; };
in
{
  programs.firefox = {
    enable = true;
    profiles = profiles;
  };

  xdg.desktopEntries.chromium = {
    categories = [ "Application" ];
    name = "Chromium";
    exec = "${pkgs.ungoogled-chromium}/bin/chromium";
    genericName = "Browser";
    icon = "${pkgs.ungoogled-chromium}/share/icons/hicolor/48x48/apps/chromium.png";
    terminal = false;
  };
}
