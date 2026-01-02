{ pkgs, ... }:
{
  hjem.users.primary.rum.programs.kitty = {
    enable = true;

    theme.no-preference = "${pkgs.kitty-themes}/share/kitty-themes/themes/moonlight.conf";

    settings = {
      cursor_trail = 5;
      font_family = "RobotoMono";
      map = [
        "ctrl+backspace send_text all \\x17"
        "ctrl+shift+t new_tab_with_cwd"
      ];
    };
  };
}
