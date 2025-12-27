{
  home-manager.users.primary.programs.kitty = {
    enable = true;

    themeFile = "moonlight";

    extraConfig = ''
      cursor_trail 5
      font_family RobotoMono
      map ctrl+backspace send_text all \x17
      map ctrl+shift+t new_tab_with_cwd
    '';
  };
}
