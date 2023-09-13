{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist/sysdata" = {
      directories = [
        "/var/lib/libvirt"
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
