{ outputs, ... }:
{
  nix.channel.enable = false;
  nix.settings = {
    auto-optimise-store = true;
    build-dir = "/var/tmp";
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    substituters = [
      "https://cache.clan.lol"
      "https://nca.cachix.org"
      "https://cache.nichi.co"
      "https://cache.ztier.in"
    ];
    trusted-public-keys = [
      "cache.clan.lol-1:3KztgSAB5R1M+Dz7vzkBGzXdodizbgLXGXKXlcQLA28="
      "nca.cachix.org-1:c8uthjrwGpyXBTBar6GWm8edgD6bErzugvlDyjNTfRc="
      "hydra.nichi.co-0:P3nkYHhmcLR3eNJgOAnHDjmQLkfqheGyhZ6GLrUVHwk="
      "cache.ztier.link-1:3P5j2ZB9dNgFFFVkCQWT3mh0E+S3rIWtZvoql64UaXM="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
    warn-dirty = false;
  };

  nixpkgs.overlays = [
    outputs.overlays.additions
    outputs.overlays.modifications
  ];

  persist.state.directories = [ "/var/lib/nixos" ];
}
