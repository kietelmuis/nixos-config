{
  description = "NixOS system config";

  inputs = {
    niri.url = "github:sodiboo/niri-flake";
    niri.inputs.nixpkgs.follows = "nixpkgs";
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    aagl.url = "github:ezKEa/aagl-gtk-on-nix";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      niri,
      nixpkgs,
      home-manager,
      aagl,
    }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      nixosConfigurations."nixos" = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inputs = { inherit niri; };
        };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            imports = [ aagl.nixosModules.default ];
            nix.settings = aagl.nixConfig;
            programs.sleepy-launcher.enable = true;
            programs.honkers-railway-launcher.enable = true;

            home-manager.backupFileExtension = "backup";
          }
        ];
      };

      devShells.${system} = {
        miata = import ./shells/miata.nix { inherit pkgs; };
        bakker = import ./shells/bakker.nix { inherit pkgs; };
      };
    };
}
