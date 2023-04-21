{ pkgs ? (import ../nixpkgs.nix) { } }: {
  banana-cursor = pkgs.callPackage ./banana-cursor.nix { };
}
