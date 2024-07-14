{ lib, pkgs, ... }:
let
  mod = "Mod4";
in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      keybindings =
        let
          pactl = lib.getExe' pkgs.pulseaudio "pactl";
          brctl = lib.getExe pkgs.brightnessctl;
          eww = "exec ${lib.getExe pkgs.eww}";
          flameshot = "exec ${lib.getExe pkgs.flameshot}";
          rofi = "exec ${lib.getExe pkgs.rofi}";
        in
        lib.mkOptionDefault {
          "${mod}+d" = "${rofi} -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary";
          "${mod}+e" = "${eww} open bar --toggle --config ~/.config/eww/bar";
          "${mod}+q" = ''${rofi} -show power-menu -modi power-menu:~/.config/rofi/power-menu.sh'';

          # Audio
          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

          # Display
          "Print" = "${flameshot} gui";
          "XF86MonBrightnessDown" = "exec ${brctl} --min-value=2 -e set 5%-";
          "XF86MonBrightnessUp" = "exec ${brctl} --min-value=2 -e set +5%";
        };

      startup = [ { command = "firefox"; } ];

      terminal = "kitty";

      window.hideEdgeBorders = "both";
      window.titlebar = false;

      workspaceLayout = "tabbed";
    };
  };
}
