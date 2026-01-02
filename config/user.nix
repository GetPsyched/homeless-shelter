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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDH+5Dygh99X3xE3oSgBHlj6aqHgjLY/rkN3tou09K88 getpsyched@brick"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWRWNijAXQx8sfBWCjqaSb79TPBoDD72YVIFnghP3+d getpsyched@piglin"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVFAeSyNREMi7aVTJQ+8yIhXZdxxIF3ySWmlSiaUJ2H getpsyched@puppeteer"
    ];
    useDefaultShell = true;
  };

  hjem = {
    clobberByDefault = true;
    extraModules = [ inputs.hjem-rum.hjemModules.default ];
    linker = null; # FIXME: hjem thinks my username is `primary`
  };

  hjem.users.primary.xdg.data.files."icons/Banana".source =
    "${pkgs.banana-cursor}/share/icons/Banana";
  hjem.users.primary.files.".Xresources".text = ''
    Xcursor.theme: Banana
    Xcursor.size: 48
  '';

  persist.cache.homeDirectories = [ ".cache" ];
}
