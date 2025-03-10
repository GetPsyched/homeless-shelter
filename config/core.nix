{ system, ... }:
{
  imports = [
    ./builders.nix
    ./nix.nix
    ./ssh.nix
    ./starship.nix
    ./tailscale.nix
    ./user.nix
  ];

  persist.cache.directories = [
    "/var/cache"
    "/var/tmp"
  ];

  nixpkgs.hostPlatform = system;
  system.stateVersion = "25.05";
}
