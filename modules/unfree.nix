{ lib, config, ... }:
{
  options = with lib; {
    allowUnfreePackages = mkOption {
      type = with types; listOf str;
      default = [ ];
      example = [ "steam" "steam-original" "steam-run" ];
    };
  };

  config = {
    nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) config.allowUnfreePackages;
  };
}
