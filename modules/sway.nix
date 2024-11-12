{config, pkgs, lib, ...}:


  {
  wayland.windowManager.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraSessionCommands = "export MOZ_ENABLE_WAYLAND=1";
    config = {
      modifier = "Mod4";
      terminal = "foot";
      menu = "rofi -show drun";
      window.titlebar = false;
      output = {
        HDMI-A-1 = {
          pos = "0 0";
        };
        eDP-1 = {
          pos = "1920 0";
        };
      };
      startup = [
        { command = "swaybg -i /home/deman/Pictures/Wallpapers/ign_robots.png"; }
        { command = "exec systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"; }
        { command = "exec systemctl --user import-environment XDG_SESSION_TYPE XDG_CURRENT_DESKTOP"; }
      ];
      gaps = {
        smartGaps = true;
        inner = 2;
        outer = 2;
      };
      bars = [
        {
          fonts.size = 15.0;
          command = "waybar";
          position = "top";
        }
      ];
      keybindings = let modifier = config.wayland.windowManager.sway.config.modifier;
        in lib.mkOptionDefault {
          "${modifier}+Shift+m" = "move scratchpad";
          "${modifier}+m" = "scratchpad show";
          "${modifier}+b" = "exec --no-startup-id rofi-bluetooth";
          "${modifier}+p" = "exec --no-startup-id rofi -show power-menu -modi power-menu:rofi-power-menu";
          "${modifier}+Shift+n" = "exec swaync-client -t -sw";
        };
  };
  };
}
