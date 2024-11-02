{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/pcloud.nix
    ./modules/greetd.nix
  ];

  nix = {
    optimise.automatic = true;
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 2d";
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
      fallback = true;
      warn-dirty = false;
      nix-path = config.nix.nixPath;
    };
  };

  boot = {
    supportedFilesystems = [ "zfs" ];
    zfs.requestEncryptionCredentials = true;
    loader.grub = {
      enable = true;
      devices = [ "nodev" ];
      efiInstallAsRemovable = true;
      efiSupport = true;
    };
  };

  networking = {
    hostId = "12a22d59";
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    hostName = "nixos"; # Define your hostname.
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Warsaw";

  i18n.defaultLocale = "pl_PL.UTF-8";

  security = {
    polkit.enable = true;
    rtkit.enable = true;
    pam.services.swaylock = { };
  };

  xdg = {
    portal = {
      enable = true;
      config.common.default = "*";
      extraPortals = with pkgs; [
        xdg-desktop-portal-wlr
        xdg-desktop-portal-gtk
      ];
    };
  };

  hardware = {
    pulseaudio.enable = false;
    bluetooth.enable = true;
    graphics.enable = true;
    enableAllFirmware = true;
  };

  services = {
    printing.enable = true;
    blueman.enable = true;
    gnome.gnome-keyring.enable = true;
    gvfs.enable = true;
    dbus.enable = true;
    zfs.autoScrub.enable = true;
    openssh.enable = true;
    tumbler.enable = true;
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      audio.enable = true;
      jack.enable = true;
    };
  };

  users = {
    defaultUserShell = pkgs.fish;
    users.deman = {
      isNormalUser = true;
      initialPassword = "garr123";
      extraGroups = [
        "wheel"
        "networkmanager"
      ]; # Enable ‘sudo’ for the user.
      packages =
        with pkgs;
        [
        ];
    };
  };

  environment = {
    variables.EDITOR = "nvim";
    sessionVariables.NIXOS_OZONE_WL = "1";
    systemPackages = with pkgs; [
      neovim
      wget
      pavucontrol
      git
      firefox
      curl
      coreutils
      gcc
      bluez5-experimental
      gvfs
      pcloud
      fuse
      nixd
      xfce.tumbler
      bluez-tools
      bluez-alsa
    ];
  };

  fonts.packages = with pkgs; [
    noto-fonts
    nerdfonts
  ];

  programs = {
    dconf.enable = true;
    fish.enable = true;
    xfconf.enable = true;
    ssh.startAgent = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
  };

  system.stateVersion = "24.05"; # Did you read the comment?
}
