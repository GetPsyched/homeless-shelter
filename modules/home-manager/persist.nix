{ config, lib, ... }:

with lib;

let cfg = config.persist; in
{
  options.persist = {
    cacheDirs = mkOption { type = with types; listOf str; default = [ ]; };
    cacheFiles = mkOption { type = with types; listOf str; default = [ ]; };

    dataDirs = mkOption { type = with types; listOf str; default = [ ]; };
    dataFiles = mkOption { type = with types; listOf str; default = [ ]; };

    gameDirs = mkOption { type = with types; listOf str; default = [ ]; };

    stateDirs = mkOption { type = with types; listOf str; default = [ ]; };
    stateFiles = mkOption { type = with types; listOf str; default = [ ]; };
  };

  config = let home = config.home.homeDirectory; in {
    home.persistence = {
      "/var/cache${home}" = { directories = cfg.cacheDirs; files = cfg.cacheFiles; allowOther = true; };

      "/persist/data${home}" = { directories = cfg.dataDirs; files = cfg.dataFiles; allowOther = true; };

      "/persist/bigdata${home}" = { directories = cfg.gameDirs; allowOther = true; };

      "/persist/state${home}" = { directories = cfg.stateDirs; files = cfg.stateFiles; allowOther = true; };
    };
  };

  meta.maintainers = [ maintainers.getpsyched ];
}
