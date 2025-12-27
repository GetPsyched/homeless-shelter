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

  home-manager.users.primary.xsession.windowManager.i3 = {
    enable = true;
    config = null;
    extraConfig = ''
      set $mod mod4

      font pango:monospace 8.000000
      workspace_layout tabbed
      focus_on_window_activation focus

      # Borders
      default_border none
      hide_edge_borders both

      # Binding modes - Resizing windows
      bindsym $mod+r mode "resize"
      mode "resize" {
        bindsym Down resize grow height 10 px or 10 ppt
        bindsym Left resize shrink width 10 px or 10 ppt
        bindsym Right resize grow width 10 px or 10 ppt
        bindsym Up resize shrink height 10 px or 10 ppt

        bindsym Escape mode "default"
        bindsym Return mode "default"
      }

      # Floating windows
      bindsym $mod+Shift+space floating toggle
      floating_modifier $mod
      default_floating_border normal 2

      # Key bindings - Applications
      bindsym $mod+Return exec ${lib.getExe config.home-manager.users.primary.programs.kitty.package}
      bindsym Print exec ${lib.getExe config.home-manager.users.primary.services.flameshot.package} gui

      # Key bindings - Brightness
      bindsym XF86MonBrightnessDown exec ${lib.getExe pkgs.brightnessctl} --min-value=2 -e set 5%-
      bindsym XF86MonBrightnessUp exec ${lib.getExe pkgs.brightnessctl} -e set +5%

      # Key bindings - Focus
      bindsym $mod+space focus mode_toggle
      bindsym $mod+Down focus down
      bindsym $mod+Left focus left
      bindsym $mod+Right focus right
      bindsym $mod+Up focus up
      bindsym $mod+a focus parent

      # Key bindings - i3 session
      bindsym $mod+Shift+r restart
      bindsym $mod+Shift+c reload

      # Key bindings - Layout
      bindsym $mod+h split h
      bindsym $mod+v split v
      bindsym $mod+s layout stacking
      bindsym $mod+e layout toggle split
      bindsym $mod+w layout tabbed
      bindsym $mod+Shift+Down move down
      bindsym $mod+Shift+Left move left
      bindsym $mod+Shift+Right move right
      bindsym $mod+Shift+Up move up

      # Key bindings - Media
      bindsym XF86AudioLowerVolume exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ -10%
      bindsym XF86AudioMicMute exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-source-mute @DEFAULT_SOURCE@ toggle
      bindsym XF86AudioMute exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-mute @DEFAULT_SINK@ toggle
      bindsym XF86AudioNext exec ${lib.getExe pkgs.playerctl} next
      bindsym XF86AudioPlay exec ${lib.getExe pkgs.playerctl} play-pause
      bindsym XF86AudioPrev exec ${lib.getExe pkgs.playerctl} previous
      bindsym XF86AudioRaiseVolume exec ${lib.getExe' pkgs.pulseaudio "pactl"} set-sink-volume @DEFAULT_SINK@ +10%

      # Key bindings - Misc. Shortcuts
      bindsym $mod+Shift+q kill
      bindsym $mod+f fullscreen toggle
      bindsym Mod1+Tab workspace back_and_forth

      # Key bindings - Rofi
      bindsym $mod+d exec ${lib.getExe pkgs.rofi} -show drun -hover-select -me-select-entry ''' -me-accept-entry MousePrimary -config ${./rofi/config.rasi}
      bindsym $mod+q exec ${lib.getExe pkgs.rofi} -show power-menu -modi power-menu:${./rofi/power-menu.sh} -config ${./rofi/power-menu.rasi}

      # Key bindings - Workspaces
      ${lib.concatStrings (
        map (n: ''
          bindsym $mod+${toString n} workspace number ${if n == 0 then "10" else toString n}
          bindsym $mod+Shift+${toString n} move container to workspace number ${
            if n == 0 then "10" else toString n
          }
        '') (builtins.genList (i: i) 10)
      )}

      # Status bars
      bar {
        colors {
          background #000000
          statusline #ffffff
          separator #666666
          focused_workspace #4c7899 #285577 #ffffff
          active_workspace #333333 #5f676a #ffffff
          inactive_workspace #333333 #222222 #888888
          urgent_workspace #2f343a #900000 #ffffff
          binding_mode #2f343a #900000 #ffffff
        }
        font pango:monospace 8.000000
        i3bar_command ${lib.getExe' config.home-manager.users.primary.xsession.windowManager.i3.package "i3bar"}
        mode hide
        status_command ${lib.getExe pkgs.i3status}
        tray_output primary
      }
    ''
    + lib.optionalString (config.specialisation != { }) ''
      exec --no-startup-id i3-msg 'workspace 1; exec firefox' # its module doesn't expose the overridden package
    '';
  };

  home-manager.users.primary.services = {
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
          temp-day = lib.mkForce 4500;
          temp-night = lib.mkForce 4500;
        };
      };
    };

    random-background = {
      enable = true;
      imageDirectory = "%h/backgrounds";
      interval = "1h";
    };
  };

  # Needed by apps like Flameshot
  systemd.user.targets.tray = {
    unitConfig = {
      Description = "Home Manager System Tray";
      Requires = [ "graphical-session-pre.target" ];
    };
  };
}
