{ lib, ... }:
let mod = "Mod4"; in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      terminal = "kitty";
      window.border = 0;
      window.titlebar = false;
      workspaceLayout = "tabbed";

      keybindings = lib.mkOptionDefault {
        "Print" = "exec flameshot gui";
      };
    };
  };
}
