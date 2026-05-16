{
  config,
  inputs,
  pkgs,
  ...
}:
{
  imports = [ inputs.hjem.nixosModules.default ];

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
    openssh.authorizedKeys.keys = (import ../keys.nix).users.primary;
    useDefaultShell = true;
  };

  hjem = {
    clobberByDefault = true;
    extraModules = [ inputs.hjem-rum.hjemModules.default ];
  };
  persist.state.directories = [ "/var/lib/hjem" ];

  hjem.users.primary.xdg.data.files."icons/Banana".source =
    "${pkgs.banana-cursor}/share/icons/Banana";
  hjem.users.primary.files.".Xresources".text = ''
    Xcursor.theme: Banana
    Xcursor.size: 48
  '';

  persist.cache.homeDirectories = [ ".cache" ];
}
