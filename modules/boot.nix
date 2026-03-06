{ pkgs, ... }:
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
  boot.extraModulePackages = [ pkgs.linuxPackages_zen.msi-ec ];
}
