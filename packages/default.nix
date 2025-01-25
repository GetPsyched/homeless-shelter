{ pkgs }:
{
  # FIXME: Cache miss for qt6.full
  # cc-nexus = pkgs.python311Packages.callPackage ../packages/nexus.nix {
  #   pyside6-essentials = (pkgs.python311Packages.callPackage ../packages/pyside6-essentials.nix { });
  # };
  mindmap = pkgs.callPackage ./mindmap.nix { };
}
