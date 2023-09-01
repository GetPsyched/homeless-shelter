{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist/sysdata" = {
      directories = [
      ];
    };

    "/persist/sysstate" = {
      directories = [
        "/etc/NetworkManager"
        "/var/lib/cloudflare-warp"
      ];
    };
  };
}
