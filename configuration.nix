{ ... }:
{
  imports = [
    ./hardware/laptop.nix
    ./modules/boot.nix
    ./modules/locale.nix
    ./modules/network.nix
    ./modules/packages.nix
    ./modules/users.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  system.stateVersion = "25.11";
}
