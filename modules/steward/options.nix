{ lib, ... }:
{
  options.persist =
    let
      inherit (lib) mkEnableOption mkOption;
      inherit (lib.types) listOf path str;

      common = {
        directories = mkOption {
          type = listOf str;
          default = [ ];
        };
        files = mkOption {
          type = listOf str;
          default = [ ];
        };
        homeDirectories = mkOption {
          type = listOf str;
          default = [ ];
        };
        homeFiles = mkOption {
          type = listOf str;
          default = [ ];
        };
      };
    in
    {
      enable = mkEnableOption "persistence";

      root = mkOption {
        type = path;
        default = "/persist";
      };

      data = common;
      state = common;
      cache = common;
      misc = common;
    };
}
