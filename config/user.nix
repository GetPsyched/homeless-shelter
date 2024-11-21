{
  config,
  inputs,
  lib,
  outputs,
  pkgs,
  ...
}:
{
  users.mutableUsers = false;
  users.users.${config.mainuser} = {
    isNormalUser = true;
    description = "Priyanshu Tripathi";
    extraGroups = [
      "dialout"
      "networkmanager"
      "wheel"
    ];
    hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
  };

  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    sharedModules = [ (import ../modules/home-manager) ];
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.${config.mainuser} = {
    home = {
      username = config.mainuser;
      homeDirectory = lib.mkDefault "/home/${config.home.username}";
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
}
