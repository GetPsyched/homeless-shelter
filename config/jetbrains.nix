{ pkgs, ... }:
{
  users.users.primary.packages = with pkgs.jetbrains; [ datagrip ];

  persist.state.homeDirectories = [
    ".config/JetBrains"
    ".local/share/JetBrains"
    ".java"
  ];

  nixpkgs.config.allowUnfreePackages = [ "datagrip" ];
}
