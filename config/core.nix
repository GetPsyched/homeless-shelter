{
  inputs,
  lib,
  system,
  ...
}:
{
  imports = [
    ./agenix.nix
    ./boot.nix
    ./builders.nix
    ./journald.nix
    ./nix.nix
    ./ssh.nix
    ./starship.nix
    ./tailscale.nix
    ./user.nix
  ];

  persist.cache.directories = [
    "/root/.cache"
    "/var/cache"
    "/var/tmp"
  ];

  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;

  nixpkgs.hostPlatform = system;
  system.stateVersion = "25.05";
}
