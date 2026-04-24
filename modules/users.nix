{ pkgs, ... }:
{
  home-manager.users.omar = import ../users/omar.nix;

  programs.zsh.enable = true;

  users.users.omar = {
    isNormalUser = true;
    description = "omar";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [
      pear-desktop
      zed-editor
      discord
      arduino-cli
      docker-compose
    ];
  };
}
