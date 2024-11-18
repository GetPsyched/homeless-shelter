{
  config,
  inputs,
  lib,
  ...
}:

let
  cfg = config.persist;
in
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

  imports = [ inputs.impermanence.nixosModules.impermanence ];

  config =
    let
      takeAll = attr: lib.concatMap (attrSet: attrSet.${attr});

      allBuckets = with cfg; [
        data
        state
        cache
        misc
      ];
      allDirectories = takeAll "directories" allBuckets;
      allFiles = takeAll "files" allBuckets;
      allHomeDirectories = takeAll "homeDirectories" allBuckets;
      allHomeFiles = takeAll "homeFiles" allBuckets;
    in
    lib.mkIf cfg.enable {
      environment.persistence.${cfg.root} = {
        directories = allDirectories;
        files = allFiles;
        users.${config.mainuser} = {
          home = "/home/${config.mainuser}";
          directories = allHomeDirectories;
          files = allHomeFiles;
        };
      };
    };
}
