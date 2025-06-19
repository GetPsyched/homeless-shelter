{ config, pkgs, ... }:
{
  persist.cache.homeDirectories = [ ".cache" ];

  # users.users.nixosvmtest = {
  #   description = "Test User";
  #   group = "nixosvmtest";
  #   initialPassword = "test";
  #   isNormalUser = true;
  # };
  users.groups.nixosvmtest = { };
  # home-manager.users.nixosvmtest.home = {
  #   username = config.users.users.nixosvmtest.name;
  #   homeDirectory = config.users.users.nixosvmtest.home;
  #   stateVersion = "22.11";
  # };

  programs.zsh.enable = true;
  users.mutableUsers = false;
  users.users.root.openssh.authorizedKeys.keys =
    config.users.users.primary.openssh.authorizedKeys.keys;
  users.users.primary = {
    description = "Priyanshu Tripathi";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    group = "nixosvmtest";
    # hashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
    home = "/home/${config.users.users.primary.name}";
    initialHashedPassword = "$y$j9T$KIZivxYTTPjQKqXxXhGRR/$ATU7co5bqgYl2rzHk9xPf5sgflqhGykTEClGx2jAiM2";
    isNormalUser = true;
    name = "getpsyched";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINWRWNijAXQx8sfBWCjqaSb79TPBoDD72YVIFnghP3+d getpsyched@piglin"
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKVFAeSyNREMi7aVTJQ+8yIhXZdxxIF3ySWmlSiaUJ2H getpsyched@puppeteer"
    ];
    shell = pkgs.zsh;
  };
}
