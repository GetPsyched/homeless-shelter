{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist/data/system" = {
      directories = [
      ];
    };

    "/persist/state/system" = {
      directories = [
        "/etc/NetworkManager"
        "/var/lib/cloudflare-warp"
      ];
    };
  };
}
