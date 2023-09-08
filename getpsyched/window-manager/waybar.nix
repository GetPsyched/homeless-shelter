{
  programs.waybar = {
    enable = true;
    style = ./waybar.css;
    settings = {
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
  };
}
