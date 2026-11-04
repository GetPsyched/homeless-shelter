{inputs, ...}: {
  additions = final: _prev: import ../packages {pkgs = final;};

  modifications = final: prev: {
    citrix-endpoint-analysis =
      (import inputs.nixpkgs-citrix {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      }).citrix-endpoint-analysis;

    hytale-launcher =
      (import inputs.nixpkgs-hytale {
        inherit (final) config;
        inherit (final.stdenv.hostPlatform) system;
      }).hytale-launcher;
  };
}
