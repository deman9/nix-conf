{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];


  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  environment.variables.EDITOR = "nvim";
  
boot.loader.grub = {
	enable = true;
	devices = ["nodev"];
	efiInstallAsRemovable = true;
	efiSupport = true;
};

boot.supportedFilesystems = ["zfs"];
boot.zfs.requestEncryptionCredentials = true;

networking.hostId = "12a22d59"; 

nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
  };


services.zfs.autoScrub.enable = true;

nixpkgs.config.allowUnfree = true;

programs.fish.enable = true;
users.defaultUserShell = pkgs.fish;
services.blueman.enable = true;

   networking.hostName = "nixos"; # Define your hostname.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.

  # Set your time zone.
   time.timeZone = "Europe/Warsaw";

  #Select internationalisation properties.
   i18n.defaultLocale = "pl_PL.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "pl";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };


  services.gnome.gnome-keyring.enable = true;
  # Optional, hint electron apps to use wayland:
 environment.sessionVariables.NIXOS_OZONE_WL = "1";


security.polkit.enable = true;

  # Enable CUPS to print documents.
   services.printing.enable = true;

xdg = {
	portal = {
	enable = true;
	config.common.default = "*";
      #	extraPortals = with pkgs; [
      #	xdg-desktop-portal-wlr
      #	xdg-desktop-portal-gtk
      #	];
	};
	};
security.rtkit.enable = true;
security.pam.services.swaylock = {
};

  # Enable sound.
   hardware = {
   	pulseaudio.enable = false;
	bluetooth.enable = true;
	graphics.enable = true;
	enableAllFirmware = true;
	};
  # OR
   services.pipewire = {
     enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
     pulse.enable = true;
    audio.enable = true;
    jack.enable = true;
   };

  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.deman = {
     isNormalUser = true;
     initialPassword = "garr123";
     extraGroups = [ "wheel" "networkmanager"]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
     ];
   };

   environment.systemPackages = with pkgs; [
     neovim 
     wget
    pavucontrol
     git
     firefox
     curl
     waybar
     wofi
     coreutils
     gcc
    bluez5-experimental 
    gvfs
    xfce.thunar-volman
    fuse
    xfce.tumbler
     bluez-tools
     bluez-alsa
   ];

  fonts.packages = with pkgs; [
  noto-fonts
  nerdfonts
  ];


  # List services that you want to enable:
  programs.ssh.startAgent = true;

  # Enable the OpenSSH daemon.
services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  system.stateVersion = "24.05"; # Did you read the comment?

}

