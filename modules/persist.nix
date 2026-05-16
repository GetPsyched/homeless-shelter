{
  config,
  hostName,
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

      prefix = paths: map (path: config.users.users.primary.home + "/" + path) paths;
      concatPaths =
        bucket: with bucket; directories ++ files ++ prefix homeDirectories ++ prefix homeFiles;
    in
    lib.mkIf cfg.enable {
      environment.persistence.${cfg.root} = {
        directories = allDirectories;
        files = allFiles;
        users.primary = {
          directories = allHomeDirectories;
          files = allHomeFiles;
        };
      };

      services.restic.backups."${hostName}-archive" = {
        initialize = true;
        environmentFile = config.age.secrets.restic-env.path;
        repository = "s3:https://s3.eu-west-par.io.cloud.ovh.net/young-de-broglie/backups/hosts/${hostName}";
        passwordFile = config.age.secrets.restic-pass.path;
        paths = concatPaths cfg.data ++ concatPaths cfg.state;
        exclude = [ "${config.users.users.primary.home}/src" ];
      };

      age.secrets.restic-env.file = "${inputs.self}/secrets/restic/env.age";
      age.secrets.restic-pass = {
        file = "${inputs.self}/secrets/restic/pass.age";
        owner = config.services.restic.backups."${hostName}-archive".user;
      };
    };
}
