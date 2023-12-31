{ config, lib, ... }:

with lib;

let cfg = config.persist; in
{
  options.persist = {
    cacheDir = mkOption { type = with types; listOf str; default = [ ]; };
    cacheFile = mkOption { type = with types; listOf str; default = [ ]; };

    dataDir = mkOption { type = with types; listOf str; default = [ ]; };
    dataFile = mkOption { type = with types; listOf str; default = [ ]; };

    games = mkOption { type = with types; listOf str; default = [ ]; };

    stateDir = mkOption { type = with types; listOf str; default = [ ]; };
    stateFile = mkOption { type = with types; listOf str; default = [ ]; };
  };

  config = let home = config.home.homeDirectory; in {
    home.persistence = {
      "/var/cache${home}" = { directories = cfg.cacheDir; files = cfg.cacheFile; allowOther = true; };

      "/persist/data${home}" = { directories = cfg.dataDir; files = cfg.dataFile; allowOther = true; };

      "/persist/bigdata${home}" = { directories = cfg.games; allowOther = true; };

      "/persist/state${home}" = { directories = cfg.stateDir; files = cfg.stateFile; allowOther = true; };
    };
  };

  meta.maintainers = [ maintainers.getpsyched ];
}
