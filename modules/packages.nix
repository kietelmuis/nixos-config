{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  fonts.fontconfig.defaultFonts = {
    sansSerif = [ "Inter Variable" ];
    serif = [ "Inter Variable" ];
    monospace = [ "Maple Mono NF" ];
  };

  fonts.packages = with pkgs; [
    inter
    maple-mono.NF
    noto-fonts-cjk-sans
  ];

  services.cpupower-gui.enable = true;
  services.flatpak.enable = true;

  virtualisation.waydroid.enable = true;
  virtualisation.docker.enable = true;

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jre;
  };

  services.dbus.enable = true;
  xdg.portal.enable = true;
  services.tailscale.enable = true;

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };

  environment.variables = {
    EDITOR = "zeditor";
    VISUAL = "micro";
    OZONE_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk}/share/dotnet";
  };

  services.upower.enable = true;

  programs.niri.enable = true;
  programs.steam.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      dotnet-runtime
      icu
      openssl
      zlib
      stdenv.cc.cc.lib
      fontconfig
    ];
  };

  services.sunshine = {
    enable = true;
    autoStart = true; # optional: starts Sunshine automatically on login
    capSysAdmin = true;
    openFirewall = true;
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet";
        user = "greeter";
      };
      terminal = {
        vt = 1;
      };
    };
  };

  environment.systemPackages = with pkgs; [
    dotnet-sdk
    xwayland-satellite
    localsend
    vscodium
    lazygit
    apktool
    cmake
    wine64
    pear-desktop
    prismlauncher
    transmission_4-gtk
    jadx
    pwvucontrol
    brightnessctl
    httptoolkit
    android-tools
    cloudflare-warp
    gnumake
    killall
    cliphist
    greetd
    tuigreet
    xwayland
    mcontrolcenter
    wget
    waydroid
    niri
    tailscale
    sunshine
    gamemode
    noctalia-shell
    nautilus
    p7zip
    micro
    protobuf
    ghostty
    cpupower-gui
    firefox
    vicinae
    upower
    git
    cargo
    gcc
    fastfetch
    pywalfox-native
    btop
    fontconfig
    freetype
    libGL
    bun
    stdenv.cc.cc.lib
    nil
    nixd
    opencode

    (mpv.override {
      scripts = with pkgs.mpvScripts; [
        uosc
        sponsorblock
      ];
    })

    (heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
  ];
}
