{ lib, pkgs, ... }:
let mod = "Mod4"; in
{
  xsession.windowManager.i3 = {
    enable = true;
    config = {
      modifier = mod;

      keybindings =
        let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          brctl = "${pkgs.brightnessctl}/bin/brightnessctl";

          # rofi
          shutdown = "";
          reboot = "";
          rofi = ''exec ${pkgs.rofi}/bin/rofi -show'';
          uptime = "`uptime -p | sed -e 's/up //g'`";
        in
        lib.mkOptionDefault {
          "${mod}+d" = "${rofi} drun";
          "${mod}+q" = ''${rofi} power-menu -modi power-menu:~/.config/rofi/power-menu.sh'';

          # Audio
          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

          # Display
          "Print" = "exec ${pkgs.flameshot}/bin/flameshot gui";
          "XF86MonBrightnessDown" = "exec ${brctl} set 5%-";
          "XF86MonBrightnessUp" = "exec ${brctl} set +5%";
        };

      startup = [
        { command = "firefox"; }
      ];

      terminal = "kitty";

      window.hideEdgeBorders = "both";
      window.titlebar = false;

      workspaceLayout = "tabbed";
    };
  };
}
