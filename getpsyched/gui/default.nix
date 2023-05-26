{ pkgs, ... }:
{
  imports = [
    ./screen-capture.nix
    ./konsole.nix
    ./sway
    # ./theme.nix
  ];
}
