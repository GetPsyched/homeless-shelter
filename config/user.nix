{
  config,
  inputs,
  pkgs,
  ...
}:
{
  # users.mutableUsers = false;
  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.primary.openssh.authorizedKeys.keys;
  users.users.primary = {
    description = "Priyanshu Tripathi";
    # extraGroups = [
    #   "networkmanager"
    #   "wheel"
    # ];
    # hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
    home = "/Users/${config.users.users.primary.name}";
    # isNormalUser = true;
    name = "getpsyched";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDH+5Dygh99X3xE3oSgBHlj6aqHgjLY/rkN3tou09K88 getpsyched@brick"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMQIemRa9gFAqLjo1PI22ObcvG0bJLcgE8Hgde5wyVkq getpsyched@mitsuko"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWRWNijAXQx8sfBWCjqaSb79TPBoDD72YVIFnghP3+d getpsyched@piglin"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVFAeSyNREMi7aVTJQ+8yIhXZdxxIF3ySWmlSiaUJ2H getpsyched@puppeteer"
    ];
    shell = config.hjem.users.primary.rum.programs.zsh.package;
    # useDefaultShell = true;
  };

  hjem = {
    clobberByDefault = true;
    extraModules = [ inputs.hjem-rum.hjemModules.default ];
  };

  # hjem.users.primary.xdg.data.files."icons/Banana".source =
  #   "${pkgs.banana-cursor}/share/icons/Banana";
  # hjem.users.primary.files.".Xresources".text = ''
  #   Xcursor.theme: Banana
  #   Xcursor.size: 48
  # '';

  persist.cache.homeDirectories = [ ".cache" ];
}
