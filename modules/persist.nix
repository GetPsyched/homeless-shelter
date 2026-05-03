{
  config,
  inputs,
  lib,
  pkgs,
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
      systemd.services.cleanupOnBoot = {
        enable = false;
        description = "Cleanup directory at boot, excluding whitelisted paths";
        wantedBy = [ "multi-user.target" ];
        after = [ "local-fs.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "cleanup-on-boot" ''
            #!/bin/sh

            WHITELIST=(${lib.concatStringsSep " " (allDirectories ++ allFiles ++ [ "/home" ])})
            echo $WHITELIST
            echo BBBBBB

            # Convert array to grep pattern
            PATTERN=$(printf "|%s" "''${WHITELIST[@]}")
            PATTERN="''${PATTERN:1}"

            # Run deletion
            echo "echoing non-whitelisted paths"
            find "${cfg.root}" | grep -vE "$PATTERN" | xargs echo
          '';
        };
      };

      environment.persistence.${cfg.root} = {
        directories = allDirectories;
        files = allFiles;
        users.primary = {
          directories = allHomeDirectories;
          files = allHomeFiles;
        };
      };
    };
}
