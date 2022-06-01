{ config, lib, pkgs, ... }:

let 
  sources = import ../../nix/sources.nix;
  i3_mod = "Mod4";
in {
  #---------------------------------------------------------------------
  # Files
  #---------------------------------------------------------------------

  home.file.".background-image".source = ./background-image;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed. Most packages I install using
  # per-project flakes sourced with direnv and nix-shell, so this is
  # not a huge list.
  home.packages = [
    pkgs.firefox-bin
  ];

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "en_US.UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.alacritty = {
    enable = true;

    settings = {
      background_opacity = 0.80;

      colors = {
        primary = {
          background = "0x1a1b26";
          foreground = "0xa9b1d6";
        };

        normal = {
          black =   "0x32344a";
          red =     "0xf7768e";
          green =   "0x9ece6a";
          yellow =  "0xe0af68";
          blue =    "0x7aa2f7";
          magenta = "0xad8ee6";
          cyan =    "0x449dab";
          white =   "0x787c99";
        };

        bright = {
          black =   "0x444b6a";
          red =     "0xff7a93";
          green =   "0xb9f27c";
          yellow =  "0xff9e64";
          blue =    "0x7da6ff";
          magenta = "0xbb9af7";
          cyan =    "0x0db9d7";
          white =   "0xacb0d0";
        };
      };

      cursor.style = "Block";

      env = {
        "TERM" = "xterm-256color";
      };

      window = {
        decorations = "Full";
        padding = {
          y = 0;
        };
      };
    };
  };

  programs.git = {
    enable = true;
    userName  = "Erik Reinert";
    userEmail = "erik@altf4.email";
  };

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-nightly;
    extraConfig = (import ./nvim.nix) {};
  };

  #---------------------------------------------------------------------
  # xsession
  #---------------------------------------------------------------------

  xsession.windowManager.i3 = {
    enable = true;

    config = {
      bars = [
        {
          position = "bottom";
          statusCommand = "${pkgs.i3status}/bin/i3status";
          colors = {
            background = "#222D31";
            statusline = "#F9FAF9";
            separator = "#454947";
            focusedWorkspace = {
              background = "#16a085";
              border = "#F9FAF9";
              text = "#292F34";
            };
            activeWorkspace = {
              background = "#353836";
              border = "#595B5B";
              text = "#FDF6E3";
            };
            inactiveWorkspace = {
              background = "#222D31";
              border = "#595B5B";
              text = "#EEE8D5";
            };
            bindingMode = {
              background = "#2C2C2C";
              border = "#16a085";
              text = "#F9FAF9";
            };
            urgentWorkspace = {
              background = "#FDF6E3";
              border = "#16a085";
              text = "#E5201D";
            };
          };
        }
      ];

      fonts = {
        names = [ "Meslo LG M Regular Nerd Font Complete Mono" ];
      };

      gaps = {
        inner = 0;
        outer = 0;
      };

      keybindings = {
        "${i3_mod}+Return" = "exec ${pkgs.alacritty}/bin/alacritty";
        "${i3_mod}+Shift+q" = "kill";

        "${i3_mod}+d" = "exec --no-startup-id ${pkgs.rofi}/bin/rofi -modi drun -show drun";

        "${i3_mod}+Left" = "focus left";
        "${i3_mod}+Down" = "focus down";
        "${i3_mod}+Up" = "focus up";
        "${i3_mod}+Right" = "focus right";

        "${i3_mod}+Shift+Left" = "move left";
        "${i3_mod}+Shift+Down" = "move down";
        "${i3_mod}+Shift+Up" = "move up";
        "${i3_mod}+Shift+Right" = "move right";

        "${i3_mod}+h" = "split h; exec notify-send 'Tile Horizontally'";
        "${i3_mod}+v" = "split v; exec notify-send 'Tile Vertically'";
        "${i3_mod}+f" = "fullscreen toggle";

        "${i3_mod}+s" = "layout stacking";
        "${i3_mod}+w" = "layout tabbed";
        "${i3_mod}+e" = "layout toggle split";

        "${i3_mod}+Shift+space" = "floating toggle";
        "${i3_mod}+space" = "focus mode_toggle";

        "${i3_mod}+a" = "focus parent";

        "${i3_mod}+Shift+minus" = "move scratchpad";
        "${i3_mod}+minus" = "scratchpad show";

        "${i3_mod}+1" = "workspace number 1";
        "${i3_mod}+2" = "workspace number 2";
        "${i3_mod}+3" = "workspace number 3";
        "${i3_mod}+4" = "workspace number 4";
        "${i3_mod}+5" = "workspace number 5";
        "${i3_mod}+6" = "workspace number 6";
        "${i3_mod}+7" = "workspace number 7";
        "${i3_mod}+8" = "workspace number 8";
        "${i3_mod}+9" = "workspace number 9";
        "${i3_mod}+0" = "workspace number 10";

        "${i3_mod}+Shift+1" = "move container to workspace number 1";
        "${i3_mod}+Shift+2" = "move container to workspace number 2";
        "${i3_mod}+Shift+3" = "move container to workspace number 3";
        "${i3_mod}+Shift+4" = "move container to workspace number 4";
        "${i3_mod}+Shift+5" = "move container to workspace number 5";
        "${i3_mod}+Shift+6" = "move container to workspace number 6";
        "${i3_mod}+Shift+7" = "move container to workspace number 7";
        "${i3_mod}+Shift+8" = "move container to workspace number 8";
        "${i3_mod}+Shift+9" = "move container to workspace number 9";
        "${i3_mod}+Shift+0" = "move container to workspace number 10";

        "${i3_mod}+Shift+c" = "reload";
        "${i3_mod}+Shift+r" = "restart";
        "${i3_mod}+Shift+e" = "exec i3-nagbar -t warning -m 'Do you want to exit i3?' -b 'Yes' 'i3-msg exit'";

        "${i3_mod}+r" = "mode resize";
      };

      modifier = i3_mod;

      window = {
        border = 0;
        hideEdgeBorders = "none";
      };
    };

    extraConfig = ''
      default_border none
      default_floating_border none
      smart_borders on
      smart_gaps on

      set_from_resource $term_background background
      set_from_resource $term_foreground foreground
      set_from_resource $term_color0     color0
      set_from_resource $term_color1     color1
      set_from_resource $term_color2     color2
      set_from_resource $term_color3     color3
      set_from_resource $term_color4     color4
      set_from_resource $term_color5     color5
      set_from_resource $term_color6     color6
      set_from_resource $term_color7     color7
      set_from_resource $term_color8     color8
      set_from_resource $term_color9     color9
      set_from_resource $term_color10    color10
      set_from_resource $term_color11    color11
      set_from_resource $term_color12    color12
      set_from_resource $term_color13    color13
      set_from_resource $term_color14    color14
      set_from_resource $term_color15    color15
    '';
  };
}