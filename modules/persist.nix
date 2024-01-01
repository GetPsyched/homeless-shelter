{ config, inputs, lib, ... }:

with lib;

let cfg = config.persist; in
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  options.persist = {
    dataDirs = mkOption { type = with types; listOf str; default = [ ]; };
    dataFiles = mkOption { type = with types; listOf str; default = [ ]; };

    stateDirs = mkOption { type = with types; listOf str; default = [ ]; };
    stateFiles = mkOption { type = with types; listOf str; default = [ ]; };
  };

  config = {
    environment.persistence = {
      "/persist/sysdata" = { directories = cfg.dataDirs; files = cfg.dataFiles; };
      "/persist/sysstate" = { directories = cfg.stateDirs; files = cfg.stateFiles; };
    };

    # Allow HM module for persistence to use `allowOther`
    programs.fuse.userAllowOther = true;
  };

  meta.maintainers = [ maintainers.getpsyched ];
}
