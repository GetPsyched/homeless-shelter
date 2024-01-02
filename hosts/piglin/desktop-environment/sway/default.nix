{ lib, pkgs, ... }:
let mod = "Mod4"; in
{
  imports = [ ./waybar.nix ];

  programs.bash = {
    initExtra = ''
      if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec sway --unsupported-gpu
      fi
    '';
  };

  wayland.windowManager.sway = {
    enable = true;
    package = pkgs.sway.override {
      sway-unwrapped = pkgs.sway-unwrapped.overrideAttrs (prev: {
        patches = prev.patches ++ [ ./sway-disable-titlebar.patch ];
      });
    };

    config = {
      modifier = mod;

      bars = [{ id = "bar-0"; mode = "hide"; command = "waybar"; }];

      keybindings =
        let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          brctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          eww = "exec ${pkgs.eww}/bin/eww";

          # rofi
          shutdown = "";
          reboot = "";
          rofi = ''exec ${pkgs.rofi}/bin/rofi -show'';
          uptime = "`uptime -p | sed -e 's/up //g'`";
        in
        lib.mkOptionDefault {
          "${mod}+d" = "${rofi} drun";
          "${mod}+e" = "${eww} open bar --toggle --config ~/.config/eww/bar";
          "${mod}+q" = ''${rofi} power-menu -modi power-menu:~/.config/rofi/power-menu.sh'';

          # Audio
          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec ${pactl} set-source-mute @DEFAULT_SOURCE@ toggle";

          # Display
          "Print" = "exec ${pkgs.gscreenshot}/bin/gscreenshot --clip --selection";
          "XF86MonBrightnessDown" = "exec ${brctl} --min-value=2 -e set 5%-";
          "XF86MonBrightnessUp" = "exec ${brctl} --min-value=2 -e set +5%";
        };

      input."type:touchpad".natural_scroll = "enabled";

      startup = [
        { command = "firefox"; }
      ];

      terminal = "kitty";

      window.hideEdgeBorders = "both";
      window.titlebar = false;

      workspaceLayout = "tabbed";
    };

    extraConfig = ''
      titlebar_padding 1
    '';
    xwayland = true;
  };
}
