{ config, pkgs, ... }:

let
  # Wraps `text` in rounded caps colored `bg`, e.g. plBlock "plpurple" "$os$username"
  plSpace = bg: "[ ](bg:${bg})";
  plStart = bg: "[](fg:${bg} bold)";
  plStartBlock = bg: text: "${plStart bg}${text}";
  plEnd = bg: "[](fg:${bg} bold) ";
  plEndBlock = bg: text: "${text}${plEnd bg}";
  plBlock = bg: text: "${plStart bg}${text}${plEnd bg}";
  homeDir = if pkgs.stdenv.hostPlatform.isDarwin then "/Users/gabs" else "/home/gabs";
in
{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "gabs";
  home.homeDirectory = homeDir;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "26.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ] ++ pkgs.lib.optionals pkgs.stdenv.isDarwin [
    pkgs.coreutils
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {

    ".config/gtk-3.0" = {
      source = ./config/gtk-3.0;
      recursive = true;
    };

    ".config/gtk-4.0" = {
      source = ./config/gtk-4.0;
      recursive = true;
    };
    
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/gabs/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.bat = {
    enable = true;
    config = {
      theme = "noctalia";
    };
  };
  home.file.".config/bat/themes/noctalia.tmTheme".source = ./config/bat/noctalia.tmTheme;

  programs.btop = {
    enable = true;
    extraConfig = {
      theme = "noctalia";
    };
  };
  home.file.".config/btop/themes/noctalia.theme".source = ./config/btop/noctalia.theme;
  home.file.".config/btop/btop.conf".source = ./config/btop/btop.conf;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableFishIntegration = true;
  };

  programs.eza = {
    enable = true;
  };

  programs.fastfetch = {
    enable = true;
  };

  home.file.".config/fastfetch/config.jsonc".source = ./config/fastfetch/config.jsonc;
  home.file.".config/fastfetch/images" = {
    source = ./config/fastfetch/images;
    recursive = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      source ~/.config/fish/main.fish
    '';
  };
  home.file.".config/fish" = {
    source = ./config/fish;
    recursive = true;
  };

  programs.fzf = {
    enable = true;
  };

  programs.git = {
    enable = true;
    settings = {
      user.name = "Gabs Simonetti";
      user.email = "6173452+gabs-simon@users.noreply.github.com";
    };
    ignores = [ "**/.claude/settings.local.json" ];
  };

  # only copy kitty configs - it should be installed natively to use GPU acceleration
  home.file.".config/kitty/themes/noctalia.conf".source = ./config/kitty/noctalia.conf;
  home.file.".config/kitty/kitty.conf".source = ./config/kitty/kitty.conf;

  programs.lazygit = {
    enable = true;
    settings.gui.theme = {
      activeBorderColor = [ "#74c7ec" "bold" ];
      inactiveBorderColor = [ "#89b4fa" ];
      searchingActiveBorderColor = [ "#89dceb" "bold" ];
      optionsTextColor = [ "#a6adc8" ];
      selectedLineBgColor = [ "#a6adc8" ];
      inactiveViewSelectedLineBgColor = [ "bold" ];
      cherryPickedCommitFgColor = [ "#a6adc8" ];
      cherryPickedCommitBgColor = [ "#89dceb" ];
      markedBaseCommitFgColor = [ "#89dceb" ];
      markedBaseCommitBgColor = [ "#f38ba8" ];
      unstagedChangesColor = [ "#f38ba8" ];
      defaultFgColor = [ "#cdd6f4" ];
    };
  };

  programs.man = {
    enable = true;
    generateCaches = true;
    package = pkgs.man;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
  };

  home.file.".config/nvim" = {
    source = ./config/nvim;
    recursive = true;
  };

  programs.pay-respects.enable = true;

  programs.starship = {
    enable = true;
    settings = {
      palette = "noctalia";
      format = "${plStart "plpurple"}$username$hostname$directory$git_branch$git_status$nodejs$bun$rust$ruby$nix_shell$time$line_break$line_break$character";
      os = {
        disabled = true;
      };

      username = {
        style_user = "bg:plpurple fg:white bold";
        style_root = "bg:plpurple fg:#FF0000 bold";
        format = "[$user]($style)";
      };

      hostname = {
        style = "bg:plpurple fg:white bold";
        format = "[@$hostname:]($style)";
      };

      directory = {
        style = "fg:white bg:plpurple bold";
        format = plEndBlock "plpurple" "[$path]($style)";
        truncation_length = 3;
        truncation_symbol = "…/";
      };

      directory.substitutions = {
        "Documents" = "󰈙 ";
        "Downloads" = " ";
        "Music" = "󰝚 ";
        "Pictures" = " ";
        "Projects" = "󰲋 ";
        ".config" = " ";
      };

      git_branch = {
        symbol = "";
        style = "bg:plyellow fg:crust bold";
        format = plStartBlock "plyellow" "[$symbol $branch]($style)";
      };

      git_status = {
        style = "bg:plyellow fg:crust bold";
        format = plEndBlock "plyellow" "[ $all_status$ahead_behind]($style)";
      };

      nodejs = {
        symbol = "";
        style = "bg:plcyan fg:crust bold";
        format = plBlock "plcyan" "[$symbol ($version)]($style)";
      };

      bun = {
        symbol = " ";
        style = "bg:plcyan fg:crust bold";
        format = plBlock "plcyan" "[$symbol ($version)]($style)";
      };

      rust = {
        symbol = " ";
        style = "bg:plcyan fg:crust bold";
        format = plBlock "plcyan" "[$symbol ($version)]($style)";
      };

      python = {
        symbol = " ";
        style = "bg:plcyan fg:crust bold";
        format = plBlock "plCyan" "[$symbol( $version)(\(#$virtualenv\))]($style)";
      };

      nix_shell = {
        style = "bg:pllightblue fg:crust bold";
        format = plBlock "pllightblue" "[$symbol$state( \($name\))]($style)";
      };

      time = {
        disabled = false;
        time_format = "%R";
        style = "bg:pldarkblue fg:text bold";
        format = plBlock "pldarkblue" "[ $time]($style)";
      };

      line_break = {
        disabled = false;
      };

      character = {
        disabled = false;
        success_symbol = "[❯](bold fg:green)";
        error_symbol = "[✖](bold fg:red)";
        vimcmd_symbol = "[❮](bold fg:green)";
        vimcmd_replace_one_symbol = "[❮](bold fg:lavender)";
        vimcmd_replace_symbol = "[❮](bold fg:lavender)";
        vimcmd_visual_symbol = "[❮](bold fg:yellow)";
      };

      cmd_duration = {
        show_milliseconds = true;
        format = " in $duration ";
        style = "bg:lavender";
        disabled = false;
        show_notifications = true;
        min_time_to_notify = 45000;
      };
      palettes.noctalia = {
        # Standard colors
        blue = "#a6ccdf";
        red = "#ffb4ab";
        green = "#8cd5b4";
        yellow = "#b3ccbe";
        cyan = "#b3ccbe";
        magenta = "#8cd5b4";
        white = "#dee4de";
        black = "#404944";

        # Extended palette (Catppuccin-compatible names)
        rosewater = "#b3ccbe";
        flamingo = "#ffb4ab";
        pink = "#8cd5b4";
        mauve = "#8cd5b4";
        maroon = "#ffb4ab";
        peach = "#b3ccbe";
        teal = "#b3ccbe";
        sky = "#b3ccbe";
        sapphire = "#a6ccdf";
        lavender = "#8cd5b4";

        # Text shades
        text = "#dee4de";
        subtext1 = "#dee4de";
        subtext0 = "#89938d";

        # Surface shades
        overlay2 = "#89938d";
        overlay1 = "#89938d";
        overlay0 = "#404944";
        surface2 = "#404944";
        surface1 = "#404944";
        surface0 = "#0f1512";
        base = "#0f1512";
        mantle = "#0f1512";
        crust = "#0f1512";

        # Powerline shades
        plpurple = "#9A348E";
        plsalmon = "#DA627D";
        plcyan = "#86BBD8";
        plyellow = "#FCA17D";
        pllightblue = "#06969A";
        pldarkblue = "#33658A";
      };
    };
  };

  programs.zoxide = {
    enable = true;
  };

  home.file.".config/zellij" = {
    source = ./config/zellij;
    recursive = true;
  };
}
