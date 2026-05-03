{ lib, pkgs, ... }:
{
  hjem.users.primary.rum.programs.zed = {
    enable = true;
    settings = {
      auto_install_extensions = lib.genAttrs [ "nix" "toml" ] (_: true);
      disable_ai = true; # I'm broke

      load_direnv = "shell_hook";

      node = {
        path = lib.getExe pkgs.nodejs;
        npm_path = lib.getExe' pkgs.nodejs "npm";
      };

      terminal.button = false;
      theme = "Ayu Dark";
    };
  };

  persist.state.homeDirectories = [ ".local/share/zed" ];
}
