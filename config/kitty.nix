{ config, pkgs, ... }:
{
  home-manager.users.primary.programs.kitty = {
    enable = true;

    extraConfig = ''
      cursor_trail 5
      map ctrl+backspace send_text all \x17
      map ctrl+shift+t new_tab_with_cwd
    '';

    font = {
      name = "RobotoMono";
      package = pkgs.roboto-mono;
    };
    themeFile = "moonlight";
  };
}
