{ pkgs, ... }:
{
  imports = [
    ../../config/direnv.nix
    # ../../config/fzf.nix
    ../../config/git.nix
    ../../config/helix.nix
    ../../config/kitty.nix
    ../../config/nix.nix
    ../../config/starship.nix
    ../../config/tailscale.nix
    ../../config/user.nix
    ../../config/zoxide.nix
    ../../config/zsh.nix
  ];

  persist.enable = false;

  environment.systemPackages = [
    pkgs.firefox
  ];

  system.defaults = {
    dock.autohide = true;
  };

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;

  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
  nixpkgs.buildPlatform = "aarch64-darwin";
}
