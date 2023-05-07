# This is your system's configuration file
# Use this to configure your system environment (it replaces /etc/nixos/configuration.nix)

{ config, pkgs, ... }: 

{
  imports = [
    # Import your generated (nixos-generate-config) hardware configuration
    ./hardware-configuration.nix
  ];

  nix = {
    settings = {
      # Enable flakes and new 'nix' command
      experimental-features = "nix-command flakes";
      # Deduplicate and optimize nix store
      auto-optimise-store = true;
    };

    gc = {
      # Enable automatic garbage collection
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };

  nixpkgs = {
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
    };
  };

  networking = {
    hostName = "awo";
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
  };

  # Use whatever bootloader you prefer
  boot.loader.systemd-boot.enable = true;
  security.polkit.enable = true;
  virtualisation.docker.enable = true;

  services = {
      pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        # If you want to use JACK applications, uncomment this
        #jack.enable = true;
    };

    openssh = {
      enable = true;
      settings = {
      # Forbid root login through SSH.
      permitRootLogin = "no";
      # Use keys only. Remove if you want to SSH using password (not recommended)
      passwordAuthentication = false;
      };
    };
  };

  environment = {
    shells = with pkgs; [ fish ];
    systemPackages = with pkgs; [
      btop
      neofetch
      ncdu
      zoxide
      neovim
      wget
      curl
      rar
      zip
      unzip
      ffmpeg
      ffmpegthumbnailer
      openjdk
      xray
      tun2socks
      docker-compose
      waybar
    ];
  };

  programs = {
    sway.enable = true;
    waybar.enable=true;
    thefuck.enable = true;

    git = {
      enable = true;
      config = {
        user.name = "awohsen";
        user.email = "awohsen@gmail.com";
        init.defaultBranch = "main";
      };
    };

    zsh = {
      enable = true;
      ohMyZsh = {
        enable = true;
        theme = "gozilla";
        plugins = [ "git" "sudo" "docker" "zoxide" "dirhistory"];
      };
      enableCompletion = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
    };
  };

  users.users = {
    # Replace with your username
    awohsen = {
      shell = pkgs.zsh;
      isNormalUser = true;
      initialPassword = "p@ssw0rd";
      openssh.authorizedKeys.keys = [
        # Add your SSH public key(s) here, if you plan on using SSH to connect
      ];
      #Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      extraGroups = [ "wheel" "docker"];
      packages = with pkgs; [
        firefox
        tdesktop
        keepassxc
        vscode
        kitty
        alacritty
     ];
    };
  };

  fonts.fonts = with pkgs; [
    corefonts
    ubuntu_font_family
    powerline-fonts
    font-awesome
    source-code-pro
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    emojione
    kanji-stroke-order-font
    ipafont
    liberation_ttf
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    jetbrains-mono
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "22.11";
}
