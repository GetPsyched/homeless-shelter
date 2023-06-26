{
  imports = [
    ./i3.nix
  ];

  home.file.".config/rofi/config.rasi".source = ./menu.rasi;
}
