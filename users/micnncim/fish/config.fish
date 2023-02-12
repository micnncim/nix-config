fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path /nix/var/nix/profiles/per-user/root/channels
fish_add_path /opt/homebrew/bin
fish_add_path /run/current-system/sw/bin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/.nix-defexpr/channels
fish_add_path $HOME/go/bin

abbr -a -U cat bat
abbr -a -U g git
abbr -a -U k kubectl
abbr -a -U kn kubens
abbr -a -U kx kubectx
abbr -a -U mkdir mkdir -p
abbr -a -U rm rip
abbr -a -U v nvim

starship init fish | source

# https://developer.1password.com/docs/cli/shell-plugins/
# source $HOME/.op/plugins.sh

if isatty
    set -x GPG_TTY (tty)
end

if not set -q TMUX
    exec tmux
end
