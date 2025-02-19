{ pkgs, ... }:
{
  extensions.packages =
    let
      ff-addons = import ../addons.nix { inherit pkgs; };
    in
    with ff-addons;
    [
      darkreader
      hoppscotch
      keepa
      multi-account-containers
      sponsorblock
      stylus
      tampermonkey
      ublock-origin
    ];

  settings = {
    "extensions.update.autoUpdateDefault" = false;
    "extensions.update.enabled" = false;
  };
}
