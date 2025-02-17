{
  config,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs outputs;
    };
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  home-manager.users.primary = {
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
}
