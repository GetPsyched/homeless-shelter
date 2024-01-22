{ config, inputs, lib, ... }:

with lib;

let
  cfg = config.persist;
  homeDir = config.home.homeDirectory;
in
{
  imports = [ inputs.impermanence.nixosModules.home-manager.impermanence ];

  options.persist = {
    cacheDirs = mkOption { type = with types; listOf str; default = [ ]; };
    cacheFiles = mkOption { type = with types; listOf str; default = [ ]; };

    dataDirs = mkOption { type = with types; listOf str; default = [ ]; };
    dataFiles = mkOption { type = with types; listOf str; default = [ ]; };

    gameDirs = mkOption { type = with types; listOf str; default = [ ]; };

    secretsDirs = mkOption { type = with types; listOf str; default = [ ]; };
    secretsFiles = mkOption { type = with types; listOf str; default = [ ]; };

    src = mkOption { type = with types; listOf str; default = [ ]; };

    stateDirs = mkOption { type = with types; listOf str; default = [ ]; };
    stateFiles = mkOption { type = with types; listOf str; default = [ ]; };
  };

  config = {
    home.persistence = {
      "/var/cache${homeDir}" = { directories = cfg.cacheDirs; files = cfg.cacheFiles; allowOther = true; };

      "/persist/data${homeDir}" = { directories = cfg.dataDirs; files = cfg.dataFiles; allowOther = true; };

      "/persist/bigdata${homeDir}" = { directories = cfg.gameDirs; allowOther = true; };

      "/persist/secrets${homeDir}" = { directories = cfg.secretsDirs; files = cfg.secretsFiles; allowOther = true; };

      "/persist/src${homeDir}" = { directories = cfg.src; allowOther = true; };

      "/persist/state${homeDir}" = { directories = cfg.stateDirs; files = cfg.stateFiles; allowOther = true; };
    };
  };

  meta.maintainers = [ maintainers.getpsyched ];
}
