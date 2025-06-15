{ pkgs, ... }:
{
  imports = [
    ../../config/nix.nix
  ];

  environment.systemPackages = [
    pkgs.helix
    pkgs.git
    pkgs.firefox
    pkgs.kitty
  ];

  services.tailscale.enable = true;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";

  # Enable alternative shell support in nix-darwin.
  programs.zsh.enable = true;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.buildPlatform = "aarch64-darwin";
}
