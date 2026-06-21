{ inputs, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    inherit
      (import inputs.nixpkgs-master {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      })
      citrix-workspace
      ;

    hytale-launcher =
      (import inputs.nixpkgs-hytale {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      }).hytale-launcher;
  };
}
