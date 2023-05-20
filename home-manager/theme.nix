{ pkgs, ... }: {
  gtk = {
    enable = true;

    cursorTheme = {
      name = "Banana";
      package = (pkgs.callPackage ../packages/banana-cursor.nix { });
      size = 48;
    };

    theme = {
      name = "sweet";
      package = pkgs.sweet;
    };
  };

  home.pointerCursor = {
    name = "Banana";
    package = (pkgs.callPackage ../packages/banana-cursor.nix { });
    size = 48;
  };
}
