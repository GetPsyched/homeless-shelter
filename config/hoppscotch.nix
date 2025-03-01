{ pkgs, ... }:
{
  users.users.primary.packages = [ pkgs.hoppscotch ];

  programs.firefox.policies.ExtensionSettings."postwoman-firefox@postwoman.io" = {
    installation_mode = "force_installed";
    install_url = "https://addons.mozilla.org/firefox/downloads/latest/postwoman-firefox@postwoman.io/latest.xpi";
  };
}
