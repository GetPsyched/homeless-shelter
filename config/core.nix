{inputs, ...}: {
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

  system.configurationRevision = inputs.self.shortRev or inputs.self.dirtyShortRev or null;

  system.stateVersion = "25.05";
}
