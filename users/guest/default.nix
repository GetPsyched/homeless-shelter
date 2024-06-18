{ hostName, ... }:
{
  users.users.guest = {
    isNormalUser = true;
    description = "Guest User";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    initialPassword = "guest";
  };

  home-manager.users.guest = import ./${hostName}.nix;
}
