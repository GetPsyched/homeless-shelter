{ pkgs, inputs, ... }:
let
  # system = "x86_64-linux";
  # ff-addons = inputs.ff-addons.packages.${system};
  profiles = {
    main = import ./profile-main.nix {
      inherit pkgs;
      ff-addons = inputs.ff-addons.packages.${pkgs.system};
    };
  };
in
{
  programs.firefox = {
    enable = true;
    profiles = profiles;
  };
}
