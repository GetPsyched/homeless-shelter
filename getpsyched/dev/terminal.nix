{ pkgs, ... }:
{
  programs.kitty = {
    enable = true;
    font = {
      name = "RobotoMono";
      package = pkgs.roboto-mono;
    };
    theme = "moonlight";
  };
}
