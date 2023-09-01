{ inputs, ... }:
{
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  programs.fuse.userAllowOther = true;

  environment.persistence = {
    "/persist/data/system" = {
      directories = [
        "/var/lib"
      ];
    };

    "/persist/state/system" = {
      directories = [
        "/etc/NetworkManager"
      ];
    };
  };
}
