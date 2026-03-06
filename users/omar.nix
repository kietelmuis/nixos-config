{ config, pkgs, ... }:

{
  home.username = "omar";
  home.homeDirectory = "/home/omar";

  home.stateVersion = "24.11";

  programs.niri.settings = {
    input.focus-follows-mouse.enable = true;
    layout.focus-ring.enable = false;
    outputs = {
      "HDMI-A-1".mode = {
        width = 1920;
        height = 1080;
        refresh = 74.973;
      };
    };
    binds = {
      "Mod+1".action.focus-workspace = 1;
      "Mod+2".action.focus-workspace = 2;
      "Mod+3".action.focus-workspace = 3;
      "Mod+4".action.focus-workspace = 4;
      "Mod+5".action.focus-workspace = 5;

      "Mod+Shift+1".action.move-column-to-workspace = 1;
      "Mod+Shift+2".action.move-column-to-workspace = 2;
      "Mod+Shift+3".action.move-column-to-workspace = 3;
      "Mod+Shift+4".action.move-column-to-workspace = 4;
      "Mod+Shift+5".action.move-column-to-workspace = 5;

      "Print".action.screenshot-screen = [ ];
      "Alt+S".action.screenshot = [ ];

      "Mod+WheelScrollDown" = {
        action.focus-workspace-down = [ ];
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action.focus-workspace-up = [ ];
        cooldown-ms = 150;
      };
      "Mod+WheelScrollRight".action.focus-column-right = [ ];
      "Mod+WheelScrollLeft".action.focus-column-left = [ ];

      "Mod+Q".action.close-window = [ ];
      "Mod+F".action.maximize-column = [ ];
      "Mod+Shift+F".action.fullscreen-window = [ ];

      "XF86AudioRaiseVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1+"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "0.1-"
      ];

      "Mod+Return".action.spawn = [
        "kitty"
      ];
      "Mod+Space".action.spawn = [
        "vicinae"
        "toggle"
      ];
    };
    spawn-at-startup = [
      { command = [ "noctalia-shell" ]; }
      {
        command = [
          "vicinae"
          "server"
        ];
      }
    ];
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      update = "cd /etc/nixos && sudo nix flake update && sudo nixos-rebuild switch";
      rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    };

    initContent = ''
      if [[ "$TERM_PROGRAM" == "" ]]; then
        fastfetch --config minimal

        clear() {
          command clear
          fastfetch --config minimal
        }
      fi

      denv() {
        nix develop /etc/nixos#$1
      }
    '';

    oh-my-zsh = {
      enable = true;
      plugins = [
        "git"
        "rust"
      ];
      theme = "robbyrussell";
    };

    history.size = 10000;
    history.path = "$HOME/.zsh_history";
    history.ignoreAllDups = true;
  };

  programs.home-manager.enable = true;
}
