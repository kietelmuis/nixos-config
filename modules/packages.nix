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
  ];

  services.flatpak.enable = true;

  virtualisation.waydroid.enable = true;
  virtualisation.docker = {
    enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jre;
  };

  services.dbus.enable = true;
  xdg.portal.enable = true;

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
    EDITOR = "zed";
    VISUAL = "micro";
    OZONE_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  environment.sessionVariables = {
    DOTNET_ROOT = "${pkgs.dotnet-sdk_10}/share/dotnet";
  };

  services.upower.enable = true;

  programs.niri.enable = true;
  programs.steam.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      dotnet-sdk_10
      icu
      openssl
      zlib
      stdenv.cc.cc.lib
      fontconfig
    ];
  };

  environment.systemPackages = with pkgs; [
    dotnet-sdk_10
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
    mpv
    jadx
    pwvucontrol
    brightnessctl
    httptoolkit
    android-tools
    cloudflare-warp
    gnumake
    geteduroam-cli
    killall
    xwayland
    mcontrolcenter
    wget
    waydroid
    niri
    noctalia-shell
    p7zip
    micro
    protobuf
    kitty
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

    (pkgs.heroic.override {
      extraPkgs =
        pkgs': with pkgs'; [
          gamescope
          gamemode
        ];
    })
  ];
}
