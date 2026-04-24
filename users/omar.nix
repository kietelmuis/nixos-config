{ config, pkgs, ... }:

{
  home.username = "omar";
  home.homeDirectory = "/home/omar";

  home.stateVersion = "24.11";

  programs.ghostty.settings = { };

  programs.niri.settings = {
    prefer-no-csd = true;
    input.focus-follows-mouse.enable = true;
    layout = {
      focus-ring.enable = false;
      gaps = 5;
    };
    outputs = {
      "HDMI-A-1".mode = {
        width = 1920;
        height = 1080;
        refresh = 74.973;
      };
    };
    binds = {
      "Alt+1".action.focus-workspace = 1;
      "Alt+2".action.focus-workspace = 2;
      "Alt+3".action.focus-workspace = 3;
      "Alt+4".action.focus-workspace = 4;
      "Alt+5".action.focus-workspace = 5;

      "Alt+Shift+1".action.move-column-to-workspace = 1;
      "Alt+Shift+2".action.move-column-to-workspace = 2;
      "Alt+Shift+3".action.move-column-to-workspace = 3;
      "Alt+Shift+4".action.move-column-to-workspace = 4;
      "Alt+Shift+5".action.move-column-to-workspace = 5;

      "Alt+L".action.spawn = [
        "noctalia-shell"
        "ipc"
        "call"
        "lockScreen"
        "lock"
      ];
      "Print".action.screenshot-screen = [ ];
      "Alt+V".action.spawn = [
        "vicinae"
        "vicinae://launch/clipboard/history"
      ];

      "Alt+WheelScrollDown" = {
        action.focus-workspace-down = [ ];
        cooldown-ms = 150;
      };
      "Alt+WheelScrollUp" = {
        action.focus-workspace-up = [ ];
        cooldown-ms = 150;
      };
      "Alt+WheelScrollRight".action.focus-column-right = [ ];
      "Alt+WheelScrollLeft".action.focus-column-left = [ ];

      "Alt+Q".action.close-window = [ ];
      "Alt+F".action.maximize-column = [ ];
      "Alt+Shift+F".action.fullscreen-window = [ ];

      "XF86AudioRaiseVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "5%+"
      ];
      "XF86AudioLowerVolume".action.spawn = [
        "wpctl"
        "set-volume"
        "@DEFAULT_AUDIO_SINK@"
        "5%-"
      ];

      "XF86MonBrightnessUp".action.spawn = [
        "brightnessctl"
        "set"
        "5%+"
      ];
      "XF86MonBrightnessDown".action.spawn = [
        "brightnessctl"
        "set"
        "5%-"
      ];

      "Alt+Return".action.spawn = [
        "ghostty"
      ];
      "Alt+Space".action.spawn = [
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
      bindkey '^H' backward-kill-word

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
