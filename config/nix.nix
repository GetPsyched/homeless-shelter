{inputs, ...}: {
  nix.channel.enable = false;
  nix.optimise.automatic = true;
  nix.settings = {
    experimental-features = [
      "flakes"
      "nix-command"
    ];
    substituters = [
      "https://cache.clan.lol"
      "https://nca.cachix.org"
    ];
    trusted-public-keys = [
      "cache.clan.lol-1:3KztgSAB5R1M+Dz7vzkBGzXdodizbgLXGXKXlcQLA28="
      "nca.cachix.org-1:c8uthjrwGpyXBTBar6GWm8edgD6bErzugvlDyjNTfRc="
    ];
    trusted-users = [
      "root"
      "@wheel"
    ];
    warn-dirty = false;
  };

  nixpkgs.overlays = with inputs.self.outputs.overlays; [
    additions
    modifications
  ];

  persist.state.directories = ["/var/lib/nixos"];
}
