{ pkgs, ... }: {
  gtk = {
    enable = true;

    cursorTheme = {
      name = "banana";
      package = (pkgs.callPackage ../packages/banana-cursor.nix { });
      size = 24;
    };

    theme = {
      name = "sweet";
      package = pkgs.sweet;
    };
  };
}
