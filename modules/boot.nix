{ pkgs, config, ... }:
{
  boot.loader.systemd-boot.enable = false;
  boot.loader.grub = {
    enable = true;
    device = "nodev";
    useOSProber = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
  };

  boot.loader.efi.efiSysMountPoint = "/boot";

  boot.kernelPackages = pkgs.linuxPackages_zen;
  boot.kernelModules = [ "msi-ec" ];
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];
  boot.extraModulePackages = [ pkgs.linuxPackages_zen.msi-ec ];

  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 4 * 1024;
    }
  ];

  zramSwap = {
    enable = true;
    algorithm = "zstd";
  };

  hardware.graphics = {
    enable = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ]; # ← top level, not inside hardware.nvidia
  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    open = false;

    # Enable the Nvidia settings menu,
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  boot.loader.grub.configurationLimit = 3;
}
