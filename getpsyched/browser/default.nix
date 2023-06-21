{ pkgs, inputs, ... }:
let
  ff-addons = inputs.ff-addons.packages.${pkgs.system};
  profiles = {
    main = import ./profile-main.nix { inherit pkgs; inherit ff-addons; };
  };
in
{
  programs.firefox = {
    enable = true;
    profiles = profiles;
  };
}
