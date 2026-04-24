{ ... }:
{
  networking.hostName = "nixos"; # Define your hostname.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.networkmanager.wifi.macAddress = "random";
  hardware.bluetooth.enable = true;
}
