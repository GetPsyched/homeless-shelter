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

  home-manager.users.primary = {
    xsession.windowManager.i3 = {
      enable = true;
      config = {
        defaultWorkspace = "1";
        modifier = "Mod4";

        keybindings =
          let
            modifier = config.home-manager.users.primary.xsession.windowManager.i3.config.modifier;

            pactl = lib.getExe' pkgs.pulseaudio "pactl";
            brctl = lib.getExe pkgs.brightnessctl;
            eww = "exec ${lib.getExe pkgs.eww}";
            flameshot = "exec ${lib.getExe pkgs.flameshot}";
            rofi = "exec ${lib.getExe pkgs.rofi}";
          in
          lib.mkOptionDefault {
            "${modifier}+d" =
              "${rofi} -show drun -hover-select -me-select-entry '' -me-accept-entry MousePrimary";
            "${modifier}+e" = "${eww} open bar --toggle --config ~/.config/eww/bar";
            "${modifier}+q" = ''${rofi} -show power-menu -modi power-menu:~/.config/rofi/power-menu.sh'';

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

    # Needed by apps like Flameshot
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
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

    services.random-background = {
      enable = true;
      imageDirectory = "%h/backgrounds";
      interval = "1h";
    };
  };
}
