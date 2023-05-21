{ pkgs, lib, ... }: {
  wayland.windowManager.sway = {
    enable = true;
    config = {
      modifier = "Mod4";
      input."type:touchpad" = {
        natural_scroll = "enabled";
        tap = "enabled";
        tap_button_map = "lmr";
      };
      output."eDP-1" = {
        scale = "2";
      };
      fonts = {
        names = [ "monospace" ];
        size = 2.0;
      };
      terminal = "${pkgs.alacritty}/bin/alacritty";
      startup = [{ command = "${pkgs.keepassxc}/bin/keepassxc"; }];
      window.border = 0;
      bars = [{ id = "bar-0"; mode = "hide"; command = "waybar"; }];
      workspaceLayout = "tabbed";
      keybindings =
        let
          pactl = "${pkgs.pulseaudio}/bin/pactl";
          brctl = "${pkgs.brightnessctl}/bin/brightnessctl";
          grim = "${pkgs.grim}/bin/grim";
          slurp = "${pkgs.slurp}/bin/slurp";
          wl-copy = "${pkgs.wl-clipboard}/bin/wl-copy";
          focusOrRun = appId: cmd: ''exec swaymsg '[app_id="${appId}" workspace="__focused__" tiling] focus' || ${cmd}'';
        in
        lib.mkOptionDefault {
          "XF86Tools" = "workspace 1";
          "XF86Launch5" = "workspace 2";
          "XF86Launch6" = "workspace 3";
          "XF86Launch7" = "workspace 4";
          "XF86Launch8" = focusOrRun "firefox" "firefox";
          "XF86Launch9" = focusOrRun "Alacritty" "alacritty";

          "XF86AudioRaiseVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ +10%";
          "XF86AudioLowerVolume" = "exec ${pactl} set-sink-volume @DEFAULT_SINK@ -10%";
          "XF86AudioMute" = "exec ${pactl} set-sink-mute @DEFAULT_SINK@ toggle";
          "XF86AudioMicMute" = "exec pactl set-source-mute @DEFAULT_SOURCE@ toggle";
          "Print" = ''exec ${grim} -g "`${slurp}`" - | ${wl-copy}'';
          "XF86MonBrightnessDown" = "exec ${brctl} set 5%-";
          "XF86MonBrightnessUp" = "exec ${brctl} set +5%";
        };
    };
    extraConfig = ''
      titlebar_padding 1
    '';
    xwayland = true;
  };
  home.packages = with pkgs; [ wl-clipboard slurp grim rofi brightnessctl ];
  programs.waybar.enable = true;
  programs.waybar.style = ./waybar.css;
  programs.waybar.settings = {
    "bar-0" = {
      ipc = true;
      layer = "top";
      position = "top";
      height = 22;
      modules-left = [ "sway/workspaces" "sway/mode" ];
      modules-right = [ "battery" "clock" "tray" ];
      "sway/workspaces" = {
        disable-scroll = true;
        all-outputs = true;
      };
    };
  };
  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors";
    size = 48;
  };
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Roboto Mono 8";
        width = 300;
        origin = "top-right";
        offset = "40x50";
        transparency = 0;
        frame_width = 2;
        separator_height = 2;
        sort = true;
      };
      urgency_low = {
        background = "#191919";
        foreground = "#BBBBBB";
      };
      urgency_normal = {
        background = "#191919";
        foreground = "#BBBBBB";
      };
      urgency_critical = {
        background = "#191919";
        foreground = "#DE6E7C";
      };
    };
  };
  services.gammastep = {
    enable = true;
    temperature.day = 4500;
    temperature.night = 4500;
    duskTime = "18:35-20:15";
    dawnTime = "6:00-7:45";
  };
}
