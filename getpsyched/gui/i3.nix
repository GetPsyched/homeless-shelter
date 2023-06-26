{ lib, pkgs, ... }:
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

      keybindings = 
        let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          brctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        in
        lib.mkOptionDefault {
          # Audio
          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

          # Display
          "Print" = "exec flameshot gui";
          "XF86MonBrightnessDown" = "exec ${brctl} set 5%-";
          "XF86MonBrightnessUp" = "exec ${brctl} set +5%";
      };
    };
  };
}
