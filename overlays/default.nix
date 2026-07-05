{ inputs, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    hytale-launcher =
      (import inputs.nixpkgs-hytale {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      }).hytale-launcher;
  };
}
