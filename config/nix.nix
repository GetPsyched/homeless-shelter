{
  config,
  inputs,
  lib,
  outputs,
  ...
}:
{
  nix = {
    # This will additionally add your inputs to the system's legacy channels
    # Making legacy nix commands consistent as well, awesome!
    nixPath = lib.mapAttrsToList (key: value: "${key}=${value.to.path}") config.nix.registry;

    # Add each flake input as a registry to make nix3 commands consistent with your flake
    registry = lib.mapAttrs (_: value: { flake = value; }) inputs;

    settings = {
      auto-optimise-store = true;
      build-dir = "/var/tmp";
      experimental-features = [
        "flakes"
        "nix-command"
      ];
      substituters = [
        "https://cache.nixos.org?priority=10"
        "https://nca.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nca.cachix.org-1:c8uthjrwGpyXBTBar6GWm8edgD6bErzugvlDyjNTfRc="
      ];
      trusted-users = [
        "root"
        "@wheel"
      ];
      warn-dirty = false;
    };
  };

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];

  persist.state.directories = [ "/var/lib/nixos" ];
}
