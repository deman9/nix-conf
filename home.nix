{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "deman";
  home.homeDirectory = "/home/deman";

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    fastfetch
    zoxide
    bat
    xfce.thunar
    xfce.thunar-volman
    eza
    starship
    fzf
    ripgrep
    transmission_4-gtk
    swaynotificationcenter
    rofi
    foot
    waybar
    swaylock
    swaybg
    swayidle
    wl-clipboard
    unzip   
    grim
    slurp
    tutanota-desktop
    yazi
    pcloud
  ];


wayland.windowManager.sway = {
	enable = true;
	wrapperFeatures.gtk = true;
	config = {
	 modifier = "Mod4";
	 terminal = "foot";
	 menu = "rofi -show drun";
         window.titlebar = false;
	output = {
	  HDMI-A-1 = { pos = "0 0";};
	  eDP-1 = {pos = "1920 0";};
      };
	 startup = [
	{command = "swaybg -i /home/deman/Pictures/Wallpapers/ign_robots.png";}
      ];
	 gaps = {
	  smartGaps = true;
	  inner = 2;
	  outer = 2;
	  
      };
	 bars = [{fonts.size = 15.0;
	 command = "waybar";
	 position = "top";
	 }];
    };

};
programs.swaylock.enable = true;
services.swaync.enable = true;
services.swayidle = {
  enable = true;
  };

programs.git = {
    enable = true;
    package = pkgs.gitAndTools.gitFull;
    userName = "deman9";
    userEmail = "andem@tuta.io";
    extraConfig = {
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };

programs.tmux = {
    keyMode = "vi";
    enable = true;
    prefix = "C-Space";
    baseIndex = 1;
    sensibleOnTop = true;
    plugins = with pkgs; [
      tmuxPlugins.nord
    ];
    extraConfig = ''
      set -g @plugin nord
      set -g renumber-windows on
      set -g status-position bottom
    '';
  };


  home.stateVersion = "24.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  
}
