{
  config,
  inputs,
  lib,
  ...
}:

let
  inherit (builtins) concatMap;
  inherit (lib.modules) mkIf;

  cfg = config.persist;
in
{
  imports = [
    inputs.impermanence.nixosModules.default
    ./options.nix
  ];

  config =
    let
      takeAll = attr: concatMap (attrSet: attrSet.${attr});

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
    mkIf cfg.enable {
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
