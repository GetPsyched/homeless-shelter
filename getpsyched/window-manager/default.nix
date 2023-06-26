{
  imports = [
    ./i3.nix
    ./notificationd.nix
  ];

  home.file.".config/rofi/config.rasi".source = ./menu.rasi;
}
