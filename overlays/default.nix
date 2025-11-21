{ inputs, ... }:
{
  additions = final: _prev: import ../packages { pkgs = final; };

  modifications = final: prev: {
    citrix_workspace =
      (import inputs.nixpkgs-citrix {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      }).citrix_workspace;

    # Pin to fix winboat
    # https://github.com/NixOS/nixpkgs/issues/462513
    nodejs_24 = prev.nodejs_24.overrideAttrs (old: rec {
      version = "24.11.0";
      src = prev.fetchurl {
        url = "https://nodejs.org/dist/v${version}/node-v${version}.tar.xz";
        hash = "sha256-z5yQbUZEZHH5VbHyxqzopGFQHYLSfhroWV3LOw4sMSo=";
      };
    });
  };
}
