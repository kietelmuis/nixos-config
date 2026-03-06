{
  description = "wsteam";
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
          pkgs.xorg.libX11
          pkgs.xorg.libICE
          pkgs.xorg.libSM
          pkgs.xorg.libXext
          pkgs.xorg.libXrender
          pkgs.xorg.libXcursor
          pkgs.xorg.libXfixes
          pkgs.xorg.libXi
          pkgs.xorg.libXrandr
        ];
        shellHook = ''
          export LD_LIBRARY_PATH="${
            pkgs.lib.makeLibraryPath [
              pkgs.xorg.libX11
              pkgs.xorg.libICE
              pkgs.xorg.libSM
              pkgs.xorg.libXext
              pkgs.xorg.libXrender
              pkgs.xorg.libXcursor
              pkgs.xorg.libXfixes
              pkgs.xorg.libXi
              pkgs.xorg.libXrandr
            ]
          }:$LD_LIBRARY_PATH"
          exec zsh
        '';
      };
    };
}
