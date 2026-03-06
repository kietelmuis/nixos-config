{ pkgs, ... }:
{
  # Load the msi-ec kernel module
  boot.kernelModules = [ "msi-ec" ];

  # Give the wheel group write access to msi-ec sysfs attributes
  # so unprivileged users can write profiles without sudo/pkexec
  services.udev.extraRules = ''
    SUBSYSTEM=="platform", DRIVER=="msi-ec", \
      RUN+="${pkgs.coreutils}/bin/chown root:wheel /sys/%p/shift_mode /sys/%p/fan_mode /sys/%p/cooler_boost /sys/%p/super_battery", \
      RUN+="${pkgs.coreutils}/bin/chmod g+w /sys/%p/shift_mode /sys/%p/fan_mode /sys/%p/cooler_boost /sys/%p/super_battery"
  '';
}
