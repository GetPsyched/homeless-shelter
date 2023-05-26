{ pkgs, ... }:
{
  imports = [
    ./flameshot.nix
    ./konsole.nix
    ./sway
    # ./theme.nix
  ];
}
