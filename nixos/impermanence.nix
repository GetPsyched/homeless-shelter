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
      files = [
        "/var/lib/prince/license.dat"
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
