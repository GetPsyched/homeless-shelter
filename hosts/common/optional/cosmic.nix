{ inputs, pkgs, ... }:
{
  imports = [ inputs.nixos-cosmic.nixosModules.default ];

  environment.cosmic.excludePackages = [
    pkgs.cosmic-edit
    pkgs.cosmic-screenshot
    pkgs.cosmic-term
    pkgs.cosmic-wallpapers
  ];

  services.desktopManager.cosmic.enable = true;
  services.displayManager.cosmic-greeter.enable = true;
}
