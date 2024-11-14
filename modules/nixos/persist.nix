{ config, inputs, lib, ... }:

with lib;

let cfg = config.persist; in
{
  imports = [ inputs.impermanence.nixosModules.impermanence ];

  options.persist = {
    enable = mkEnableOption "persistence";

    sysDataDirs = mkOption { type = with types; listOf str; default = [ ]; };
    sysDataFiles = mkOption { type = with types; listOf str; default = [ ]; };

    sysStateDirs = mkOption { type = with types; listOf str; default = [ ]; };
    sysStateFiles = mkOption { type = with types; listOf str; default = [ ]; };
  };

  config = mkIf cfg.enable {
    environment.persistence = {
      "/persist/sysdata" = { directories = cfg.sysDataDirs; files = cfg.sysDataFiles; };
      "/persist/sysstate" = { directories = cfg.sysStateDirs; files = cfg.sysStateFiles; };
    };

    # Allow HM module for persistence to use `allowOther`
    programs.fuse.userAllowOther = true;
  };

  meta.maintainers = [ maintainers.getpsyched ];
}
