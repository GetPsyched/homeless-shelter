{ inputs, pkgs, ... }:
{
  imports = [ inputs.hjem.nixosModules.default ];

  hjem = {
    clobberByDefault = true;
    extraModules = [ inputs.hjem-rum.hjemModules.default ];
    # linker = inputs.hjem.packages.smfh;
  };

  hjem.users.primary.xdg.data.files."icons/Banana".source =
    "${pkgs.banana-cursor}/share/icons/Banana";
  # hjem.users.primary.rum.misc.gtk.settings.cursor-theme-name = "Banana";
  hjem.users.primary.files.".Xresources".text = ''
    Xcursor.theme: Banana
    Xcursor.size: 48
  '';
}
