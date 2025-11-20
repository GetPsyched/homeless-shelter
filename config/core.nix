{
  inputs,
  lib,
  system,
  ...
}:
{
  imports = [
    ./boot.nix
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

  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

  nixpkgs.hostPlatform = system;
  system.stateVersion = "25.05";
}
