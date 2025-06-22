{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.displayManager = {
    enable = true;
    autoLogin.enable = true;
    autoLogin.user = config.users.users.primary.name;
    defaultSession = "none+i3";
  };

  services.libinput.touchpad = {
    disableWhileTyping = true;
    naturalScrolling = true;
  };

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
    xkb.layout = "us";
  };

  hjem.users.primary.rum.desktops.i3 = {
    enable = true;
    settings = {
      bindsym = [
        "$mod+0 workspace number 10"
        "$mod+1 workspace number 1"
        "$mod+2 workspace number 2"
        "$mod+3 workspace number 3"
        "$mod+4 workspace number 4"
        "$mod+5 workspace number 5"
        "$mod+6 workspace number 6"
        "$mod+7 workspace number 7"
        "$mod+8 workspace number 8"
        "$mod+9 workspace number 9"
        "$mod+d exec ${lib.getExe pkgs.rofi} -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary"
        "$mod+q exec ${lib.getExe pkgs.rofi} -show power-menu -modi power-menu:${./rofi/power-menu.sh}"
        "$mod+shift+0 move container to workspace number 10"
        "$mod+shift+1 move container to workspace number 1"
        "$mod+shift+2 move container to workspace number 2"
        "$mod+shift+3 move container to workspace number 3"
        "$mod+shift+4 move container to workspace number 4"
        "$mod+shift+5 move container to workspace number 5"
        "$mod+shift+6 move container to workspace number 6"
        "$mod+shift+7 move container to workspace number 7"
        "$mod+shift+8 move container to workspace number 8"
        "$mod+shift+9 move container to workspace number 9"
        "$mod+shift+r restart"
        "Print exec ${lib.getExe pkgs.flameshot} gui"
        "XF86AudioLowerVolume exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ -10%"
        "XF86AudioMicMute exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-source-mute @DEFAULT_SOURCE@ toggle"
        "XF86AudioMute exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-mute @DEFAULT_SINK@ toggle"
        "XF86AudioNext exec ${lib.getExe pkgs.playerctl} next"
        "XF86AudioPlay exec ${lib.getExe pkgs.playerctl} play-pause"
        "XF86AudioPrev exec ${lib.getExe pkgs.playerctl} previous"
        "XF86AudioRaiseVolume exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ +10%"
        "XF86MonBrightnessDown exec ${lib.getExe pkgs.brightnessctl} --min-value 2 -e set 5%-"
        "XF86MonBrightnessUp exec ${lib.getExe pkgs.brightnessctl} -e set +5%"
      ];
      default_border = "none";
      floating_modifier = "$mod";
      hide_edge_borders = "both";
      set = [ "$mod mod4" ];
      workspace_auto_back_and_forth = "yes";
      workspace_layout = "tabbed";
    };
    extraConfig = ''
      exec --no-startup-id i3-msg 'workspace 1; exec ${lib.getExe pkgs.firefox}'
    '';
  };

  hjem.users.primary.rum.programs = {
    dunst = {
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

    gammastep = {
      enable = true;
      settings = {
        general = {
          dawn-time = "6:00-7:45";
          dusk-time = "18:35-20:15";
          location-provider = "manual";
          temp-day = 4500;
          temp-night = 4500;
        };
      };
    };
  };

  # home-manager.users.primary.services.random-background = {
  #   enable = true;
  #   imageDirectory = "%h/backgrounds";
  #   interval = "1h";
  # };
}
