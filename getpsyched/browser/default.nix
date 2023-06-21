{ pkgs, inputs, ... }:
let
  ff-addons = import ./addons.nix {
    ff-addons = inputs.ff-addons.packages.${pkgs.system};
    inherit (inputs.ff-addons.lib.${pkgs.system}) buildFirefoxXpiAddon;
  };
  profiles = {
    main = import ./profile-main.nix { inherit ff-addons pkgs; };
  };
in
{
  programs.firefox = {
    enable = true;
    profiles = profiles;
  };
}
