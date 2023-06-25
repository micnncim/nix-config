fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path /nix/var/nix/profiles/per-user/root/channels
fish_add_path /opt/homebrew/bin
fish_add_path /run/current-system/sw/bin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/.nix-defexpr/channels
fish_add_path $HOME/go/bin

# Use `--regex` to avoid conflicts with other abbreviations.
abbr -a bat --regex '^cat$' bat
abbr -a code --regex '^c$' code
abbr -a git --regex '^g$' git
abbr -a help --regex '^h$' help
abbr -a kubectl --regex '^k$' kubectl
abbr -a kubectx --regex '^kc$' kubectx
abbr -a kubectl --regex '^kn$' kubens
abbr -a mkdir --regex '^mkdir$' mkdir -p
abbr -a rip --regex '^rm$' rip
abbr -a nvim --regex '^v$' nvim

abbr -a --position anywhere --function __abbr_flag_ctx -- -ctx
abbr -a --position anywhere --function __abbr_flag_n -- -n
abbr -a --position anywhere --function __abbr_flag_p -- -p

abbr -a --position anywhere --function __abbr_subcommand_d -- d
abbr -a --position anywhere --function __abbr_subcommand_g -- g
abbr -a --position anywhere --function __abbr_subcommand_l -- l

starship init fish | source

test -r "$XDG_CONFIG_HOME/dircolors/.dircolors" && eval (dircolors -c "$XDG_CONFIG_HOME/dircolors/.dircolors")

# https://developer.1password.com/docs/cli/shell-plugins/
# source $HOME/.op/plugins.sh

if isatty
    set -x GPG_TTY (tty)
end

if not set -q TMUX
    exec tmux
end
