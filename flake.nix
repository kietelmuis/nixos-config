{
  description = "Miata Dash environment";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs =
    {
      self,
      nixpkgs,
      home-manager,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
        ];
      };

      devShells.${system}.default = pkgs.mkShell {
        buildInputs = [
          pkgs.protobuf
          pkgs.cmake
          pkgs.boost
          pkgs.openssl
          pkgs.libusb1
          pkgs.rtaudio
          pkgs.qt5.qtbase
          pkgs.qt5.qtmultimedia
          pkgs.qt5.qtconnectivity
          pkgs.qt5.qtwayland
          pkgs.gst_all_1.gstreamer
          pkgs.gst_all_1.gst-plugins-base
          pkgs.gst_all_1.gst-plugins-good
        ];
        shellHook = ''
          export QT_QPA_PLATFORM=wayland
          export GST_PLUGIN_SYSTEM_PATH_1_0="${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0"
          exec zsh
        '';
      };
    };
}
