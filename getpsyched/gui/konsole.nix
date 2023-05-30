{ pkgs, fetchFromGitHub, ... }:

let
  utterly-sweet-theme = pkgs.fetchFromGitHub {
    owner = "HimDek";
    repo = "Utterly-Sweet-Plasma";
    rev = "master";
    sha256 = "oEyf6FI5XSjXPZjzBiGypwZY89ulhwAwk9QIJ3pMw/M=";
  };
in
{
  home.packages = with pkgs; [
    (runCommand "utterly-sweet-theme" { } ''
      mkdir -p $out/share/konsole
      cp ${utterly-sweet-theme}/Utterly-Sweet-Konsole.colorscheme $out/share/konsole/Utterly-Sweet.colorscheme
    '')
  ];
}
