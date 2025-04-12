# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.supportedFilesystems = [ "ntfs" ];
  fileSystems."/data" = {
    device = "/dev/sda1";
    fsType = "ntfs-3g";
    options = ["rw" "uid=1000" "gid=1000" "fmask=133" "dmask=022"];
  };
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    useOSProber = true;
    configurationLimit = 2;
    device = "nodev";
  };

  networking.hostName = "latitude"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Kolkata";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_IN";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sarvex = {
    isNormalUser = true;
    description = "Sarvex";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
    packages = with pkgs; [
      kdePackages.kate
      thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.yazi.enable = true;
  programs.xonsh.enable = true;
  programs.wireshark.enable = true;
  programs.vim.enable = true;
  programs.traceroute.enable = true;
  programs.thefuck.enable = true;
  programs.steam.enable = true;
  programs.starship.enable = true;
  programs.obs-studio.enable = true;
  programs.npm.enable = true;
  programs.neovim.enable = true;
  programs.lazygit.enable = true;
  programs.java.enable = true;
  programs.htop.enable = true;
  programs.git.enable = true;
  programs.git.lfs.enable = true;
  programs.fish.enable = true;
  programs.chromium.enable = true;
  programs.autojump.enable = true;
  programs.atop.enable = true;
  programs.appimage.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  nixpkgs.config.permittedInsecurePackages = [ "openssl-1.1.1w"];

  # nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];
  nix.optimise.automatic = true;
  nix.gc.automatic = true;
  nix.settings = {
    auto-optimise-store = true;
    experimental-features = [ "nix-command" "flakes" ];
  };
  
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    nixd
    os-prober
    zoxide
    eza
    fzf
    xclip
    wget
    bat
    ntfs3g
    openssl
    alejandra
    clang
    gcc
    sccache
    go
    rustup
    alacritty
    alacritty-theme
    ghostty
    wezterm
    kitty
    emacs
    vim-full
    sublime4
    zed-editor
    windsurf
    brave
    vivaldi
    # yandex-browser
    tor-browser
    palemoon-bin
    # opera
    # midori
    firedragon
    floorp
    librewolf
    google-chrome
    ungoogled-chromium
    code-cursor
    vscode
    home-manager
  ] ++ ( with kdePackages; [
      # rocs
      kwin
      dolphin
      okular
      kdenlive
      konsole
      gwenview
      krita
      spectacle
      discover
      kfind
      kcalc
      kfind
      yakuake
      kompare
      # kamoso
      elisa
      ktorrent
      kcachegrind
      haruna
      ktimer
      kdevelop
      kmail
      korganizer
      # ktouch
      ksudoku
      kontact
      marble
      merkuro
      dragon
      partitionmanager
      falkon
  ]) ++ ( with nerd-fonts; [
      _0xproto
      _3270
      agave
      anonymice
      arimo
      aurulent-sans-mono
      bigblue-terminal
      bitstream-vera-sans-mono
      blex-mono
      caskaydia-cove
      code-new-roman
      comic-shanns-mono
      commit-mono
      cousine
      d2coding
      daddy-time-mono
      dejavu-sans-mono
      departure-mono
      droid-sans-mono
      envy-code-r
      fantasque-sans-mono
      fira-code
      geist-mono
      go-mono
      gohufont
      hack
      hasklug
      heavy-data
      hurmit
      im-writing
      inconsolata
      inconsolata-go
      inconsolata-lgc
      intone-mono
      iosevka
      iosevka-term
      iosevka-term-slab
      jetbrains-mono
      lekton
      liberation
      lilex
      martian-mono
      meslo-lg
      monaspace
      monofur
      monoid
      mononoki
      mplus
      noto
      open-dyslexic
      overpass
      profont
      proggy-clean-tt
      recursive-mono
      roboto-mono
      sauce-code-pro
      shure-tech-mono
      space-mono
      symbols-only
      terminess-ttf
      ubuntu
      ubuntu-mono
      victor-mono
      zed-mono
  ]);

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
