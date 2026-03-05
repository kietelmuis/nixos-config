{ pkgs, lib, ... }:
{
  nixpkgs.config.allowUnfree = true;

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  fonts.packages = with pkgs; [
    inter
    maple-mono.NF
  ];

  services.flatpak.enable = true;

  virtualisation.docker = {
    enable = true;
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.java = {
    enable = true;
    package = pkgs.jre;
  };

  environment.variables = {
    EDITOR = "zed";
    VISUAL = "micro";
    OZONE_PLATFORM = "wayland";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  environment.sessionVariables = {
    LD_LIBRARY_PATH =
      with pkgs;
      lib.makeLibraryPath [
        fontconfig
      ];
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
    httptoolkit
    android-tools
    cloudflare-warp
    gnumake
    geteduroam-cli
    killall
    xwayland
    mcontrolcenter
    wget
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
