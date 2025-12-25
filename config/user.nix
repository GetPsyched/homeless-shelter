{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.default ];

  users.mutableUsers = false;
  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.primary.openssh.authorizedKeys.keys;
  users.users.primary = {
    description = "Priyanshu Tripathi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
    home = "/home/${config.users.users.primary.name}";
    isNormalUser = true;
    name = "getpsyched";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDH+5Dygh99X3xE3oSgBHlj6aqHgjLY/rkN3tou09K88 getpsyched@brick"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWRWNijAXQx8sfBWCjqaSb79TPBoDD72YVIFnghP3+d getpsyched@piglin"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVFAeSyNREMi7aVTJQ+8yIhXZdxxIF3ySWmlSiaUJ2H getpsyched@puppeteer"
    ];
    useDefaultShell = true;
  };

  home-manager = {
    extraSpecialArgs = { inherit inputs outputs; };
    useGlobalPkgs = true;
    useUserPackages = true;

    users.primary = {
      home = {
        username = config.users.users.primary.name;
        homeDirectory = config.users.users.primary.home;
        stateVersion = "22.11";

        pointerCursor = {
          name = "Banana";
          size = 48;
          package = pkgs.banana-cursor;
          x11.enable = true;
          gtk.enable = true;
        };
      };

      # Nicely reload system units when changing configs
      systemd.user.startServices = "sd-switch";
    };
  };

  persist.cache.homeDirectories = [ ".cache" ];
}
