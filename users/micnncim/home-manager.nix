{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  username = "micnncim";
  inherit (pkgs) stdenv;
in
{
  home.stateVersion = "22.11";

  xdg.enable = true;

  #---------------------------------------------------------------------
  # Packages
  #---------------------------------------------------------------------

  # Packages I always want installed.
  home.packages = with pkgs;
    [
      # Core
      coreutils
      curl
      git
      tree
      watch
      wget

      # Utils
      bat
      delta
      fd
      jq
      neofetch
      pre-commit
      procs
      ripgrep
      rm-improved
      sd
      tealdeer
      typos
      unstable.atuin
      unstable.eza
      unstable.markdownlint-cli
      unstable.ripsecrets

      # Dev
      (google-cloud-sdk.withExtraComponents
        ([ google-cloud-sdk.components.gke-gcloud-auth-plugin ]))
      ghq
      git-lfs
      nodejs_18 # For CopilotForXcode
      pinentry
      shellcheck
      starship

      # Language servers
      nil
      nodePackages.bash-language-server
      unstable.yaml-language-server

      # Container
      kubectl
      kubectx
      podman
      qemu
      stern

      # Nix
      cachix
      comma
      niv
      nix-init
      nixpkgs-fmt
      nurl

      # Fonts
      nerdfonts

      # GUI
      alacritty

      # NUR
      nur.repos.micnncim.gctx
      nur.repos.micnncim.kubectl-reveal-secret
      nur.repos.micnncim.slack-cli
    ] ++ lib.optionals stdenv.isDarwin [ pinentry_mac ];

  home.shellAliases = {
    ll = "eza -la";
    llt =
      "eza -laTF --git --group-directories-first --git-ignore --ignore-glob .git";
    ls = "eza";
    lt = "eza -T";
  };

  #---------------------------------------------------------------------
  # Env vars and dotfiles
  #---------------------------------------------------------------------

  home.homeDirectory = "/Users/${username}";

  home.sessionVariables = {
    LANG = "en_US.UTF-8";
    LC_CTYPE = "UTF-8";
    LC_ALL = "en_US.UTF-8";
    EDITOR = "nvim";
    PAGER = "less";
    MANPAGER = "sh -c 'col -bx | ${pkgs.bat}/bin/bat -l man -p'";
    BAT_CONFIG_PATH = "${config.xdg.configHome}/bat/.batrc";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/.ripgreprc";
    STARSHIP_CONFIG = "${config.xdg.configHome}/starship/starship.toml";
    # https://cloud.google.com/blog/products/containers-kubernetes/kubectl-auth-changes-in-gke
    USE_GKE_GCLOUD_AUTH_PLUGIN = "True";
  };

  home.file."${config.programs.gpg.homedir}/gpg-agent.conf".text =
    lib.mkIf stdenv.isDarwin ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 34560000
      max-cache-ttl 34560000
      log-file /var/log/gpg-agent.log
    '';

  xdg.configFile = {
    "alacritty/alacritty.yml".source = ./alacritty.yml;
    "bat/.batrc".source = ./.batrc;
    "dircolors/.dircolors".source = ./.dircolors;
    "fd/ignore".source = ./fdignore;
    "git" = {
      recursive = true;
      source = ./git;
    };
    "git/templates/hooks".source =
      config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/hooks";
    "karabiner/karabiner.json".source = ./karabiner.json;
    "pre-commit/.pre-commit-config.yaml".source = ./.pre-commit-config.yaml;
    "ripgrep/.ripgreprc".source = ./.ripgreprc;
    "starship/starship.toml".source = ./starship.toml;
  };

  #---------------------------------------------------------------------
  # Programs
  #---------------------------------------------------------------------

  programs.home-manager.enable = true;

  programs.bash.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  programs.fish = {
    enable = true;
    functions = {
      # Do not show any greeting
      fish_greeting = "";
      fish_user_key_bindings = ''
        bind \c] __ghq_jump
      '';
    } // builtins.listToAttrs (map
      (n: {
        name = n;
        value = (builtins.readFile ./fish/functions/${n}.fish);
      }) [
      "__abbr_flag_ctx"
      "__abbr_flag_n"
      "__abbr_flag_o"
      "__abbr_flag_p"
      "__abbr_subcommand_d"
      "__abbr_subcommand_g"
      "__abbr_subcommand_l"
      "__ghq_jump"
      "fkill"
      "help"
      "xcode"
    ]);
    interactiveShellInit = lib.strings.concatStrings
      (lib.strings.intersperse "\n" [
        "fish_add_path /etc/profiles/per-user/${username}/bin"
        "source ${pkgs.google-cloud-sdk}/google-cloud-sdk/path.fish.inc"
        (builtins.readFile ./fish/config.fish)
      ]);
    plugins = map
      (n: {
        name = n;
        src = sources.${n};
      }) [
      "fish-bass"
      "fish-foreign-env"
      "fish-gcloud-completion"
      "fish-nix-env"
    ];
  };

  programs.fzf = {
    enable = true;
    defaultOptions = [ "--reverse" "--height 40%" "--multi" "--cycle" ];
    # Nord theme
    # Ref: https://github.com/ianchesal/nord-fzf
    colors = {
      "fg" = "#e5e9f0";
      "bg" = "#2e3440";
      "hl" = "#81a1c1";
      "fg+" = "#e5e9f0";
      "bg+" = "#2e3440";
      "hl+" = "#81a1c1";
      "info" = "#eacb8a";
      "prompt" = "#bf6069";
      "pointer" = "#b48dac";
      "marker" = "#a3be8b";
      "spinner" = "#b48dac";
      "header" = "#a3be8b";
    };
  };

  programs.gh = {
    enable = true;
    extensions = with pkgs; [
      gh-dash
      nur.repos.micnncim.gh-sync
    ];
    settings = {
      aliases = {
        b = "!gh browse -b $(git rev-parse --abbrev-ref HEAD)";
      };
    };
  };

  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
    scdaemonSettings = { disable-ccid = true; };
  };

  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs; [
      vimPlugins.copilot-vim
      vimPlugins.nord-nvim
      vimPlugins.nvim-treesitter
      vimPlugins.nvim-treesitter-textobjects
      vimPlugins.vim-markdown
      {
        plugin = vimPlugins.hop-nvim;
        type = "lua";
        config = ''
          require("hop").setup { keys = 'uhetonas' } -- Dvorak
          nmap("<Leader>w", ":HopWord<CR>")
          nmap("<Leader>l", ":HopLine<CR>")
          nmap("<Leader>s", ":HopChar1<CR>")
        '';
      }
      {
        plugin = vimPlugins.nvim-surround;
        type = "lua";
        config = ''
          require("nvim-surround").setup()
        '';
      }
    ];
    extraConfig = ''
      colorscheme nord

      set number

      nnoremap <Space> <Nop>
      let g:mapleader = "\<Space>"
    '';
    extraLuaConfig = ''
      local function nmap(shortcut, command, opts)
        vim.keymap.set("n", shortcut, command, opts or { noremap = true, silent = true })
      end
    '';
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.copycat
      tmuxPlugins.fzf-tmux-url
      tmuxPlugins.logging
      tmuxPlugins.open
      tmuxPlugins.prefix-highlight
      tmuxPlugins.resurrect
      tmuxPlugins.tmux-fzf
      tmuxPlugins.yank
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'alacritty' 
        '';
      }
      {
        plugin = tmuxPlugins.nord;
        extraConfig = ''
          # Disable patched fonts.
          # https://www.nordtheme.com/docs/ports/tmux/configuration
          set -g @nord_tmux_no_patched_font '1'
        '';
      }
    ];
    extraConfig = builtins.readFile ./tmux.conf;
  };
}
