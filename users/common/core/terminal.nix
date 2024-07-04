{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;

    extraConfig = ''
      map ctrl+shift+t new_tab_with_cwd
    '';

    font = {
      name = "RobotoMono";
      package = pkgs.roboto-mono;
    };
    theme = "moonlight";
  };
}
