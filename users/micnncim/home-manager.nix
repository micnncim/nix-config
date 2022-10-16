{ config, lib, pkgs, ... }:

let
  sources = import ../../nix/sources.nix;
  username = "micnncim";
  inherit (pkgs) stdenv;
in
{
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
      tmux
      tree
      watch
      wget

      # Utils
      bat
      delta
      exa
      fd
      jq
      pre-commit
      procs
      ripgrep
      rm-improved
      sd
      tealdeer
      typos

      # Dev
      buildkit
      cachix
      docker
      docker-compose
      gh
      ghq
      google-cloud-sdk
      gopls
      krew
      kubectl
      kubectx
      pinentry
      rnix-lsp
      starship
      stern
      tailscale

      # Node packages
      nodePackages.markdownlint-cli

      # GUI
      alacritty
      slack
      vscode

      # Custom packages
      _gctx
    ] ++ lib.optionals stdenv.isDarwin [ pinentry_mac ];

  home.shellAliases = {
    ll = "exa -la";
    llt = "exa -laTF --git --group-directories-first --git-ignore --ignore-glob .git";
    ls = "exa";
    lt = "exa -T";
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
    GOROOT = "${pkgs.go}/share/go";
    RIPGREP_CONFIG_PATH = "${config.xdg.configHome}/ripgrep/.ripgreprc";
    STARSHIP_CONFIG = "${config.xdg.configHome}/starship/starship.toml";
  };

  home.file."${config.programs.gpg.homedir}/gpg-agent.conf".text =
    lib.mkIf stdenv.isDarwin ''
      pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      default-cache-ttl 34560000
      max-cache-ttl 34560000
      log-file /var/log/gpg-agent.log
    '';

  xdg.configFile."alacritty/alacritty.yml".source = ./alacritty.yml;
  xdg.configFile."bat/.batrc".source = ./.batrc;
  xdg.configFile."fd/ignore".source = ./fdignore;
  xdg.configFile."gh/config.yml".source = ./gh/config.yml;
  xdg.configFile."git" = {
    recursive = true;
    source = ./git;
  };
  xdg.configFile."git/templates/hooks".source =
    config.lib.file.mkOutOfStoreSymlink "${config.xdg.configHome}/git/hooks";
  xdg.configFile."karabiner/karabiner.json".source = ./karabiner.json;
  xdg.configFile."pre-commit/.pre-commit-config.yaml".source =
    ./.pre-commit-config.yaml;
  xdg.configFile."ripgrep/.ripgreprc".source = ./.ripgreprc;
  xdg.configFile."starship/starship.toml".source = ./starship.toml;
  xdg.configFile."tmux" = {
    recursive = true;
    source = ./tmux;
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
      __ghq_jump = (builtins.readFile ./fish/functions/__ghq_jump.fish);
      fkill = (builtins.readFile ./fish/functions/fkill.fish);
      help = (builtins.readFile ./fish/functions/help.fish);
    };
    interactiveShellInit = lib.strings.concatStrings (lib.strings.intersperse "\n" [
      "fish_add_path /etc/profiles/per-user/${username}/bin"
      "source ${pkgs.google-cloud-sdk}/google-cloud-sdk/path.fish.inc"
      (builtins.readFile ./fish/config.fish)
      "set -g SHELL ${pkgs.fish}/bin/fish"
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
  };

  programs.go = {
    enable = true;
    goPath = "go";
    goBin = "go/bin";
    goPrivate = [ "github.com/micnncim" ];
  };

  programs.gpg = {
    enable = true;
    homedir = "${config.home.homeDirectory}/.gnupg";
    scdaemonSettings = { disable-ccid = true; };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs; [ vimPlugins.onehalf vimPlugins.vim-markdown ];
    extraConfig = ''
      colorscheme onehalfdark

      set number
    '';
  };

  programs.tmux = {
    enable = true;
    plugins = with pkgs; [
      tmuxPlugins.resurrect
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-save-interval '5' # minutes
        '';
      }
      tmuxPlugins.copycat
      tmuxPlugins.yank
      tmuxPlugins.open
      tmuxPlugins.logging
      tmuxPlugins.tmux-fzf
      tmuxPlugins.fzf-tmux-url
    ];
  };
}
