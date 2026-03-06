{ inputs, ... }:
{
  imports = [
    inputs.niri.nixosModules.niri
    ./hardware/laptop.nix
    ./hardware/msi-ec.nix
    ./modules/boot.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/packages.nix
    ./modules/users.nix
  ];

  nix.settings.trusted-users = [
    "root"
    "omar"
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
