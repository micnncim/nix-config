fish_add_path /nix/var/nix/profiles/default/bin
fish_add_path /nix/var/nix/profiles/per-user/root/channels
fish_add_path /opt/homebrew/bin
fish_add_path /run/current-system/sw/bin
fish_add_path $HOME/.krew/bin
fish_add_path $HOME/.nix-defexpr/channels
fish_add_path $GOBIN

# Use `--regex` to avoid conflicts with other abbreviations.
abbr -a bat --regex '^cat$' bat
abbr -a cursor --regex '^c$' cursor
abbr -a ghq --regex '^ghq$' ghq get -p
abbr -a git --regex '^g$' git
abbr -a help --regex '^h$' help
abbr -a kubectl --regex '^k$' kubectl
abbr -a kubectx --regex '^kc$' kubectx
abbr -a kubens --regex '^kn$' kubens
abbr -a make --regex '^m$' make
abbr -a mkdir --regex '^mkdir$' mkdir -p
abbr -a nvim --regex '^v$' nvim
abbr -a rip --regex '^rm$' rip
abbr -a xcode --regex '^x$' xcode

abbr -a --position anywhere --function __abbr_flag_ctx -- -ctx
abbr -a --position anywhere --function __abbr_flag_n -- -n
abbr -a --position anywhere --function __abbr_flag_o -- -o
abbr -a --position anywhere --function __abbr_flag_p -- -p

abbr -a --position anywhere --function __abbr_subcommand_a -- a
abbr -a --position anywhere --function __abbr_subcommand_ab -- ab
abbr -a --position anywhere --function __abbr_subcommand_b -- b
abbr -a --position anywhere --function __abbr_subcommand_c -- c
abbr -a --position anywhere --function __abbr_subcommand_d -- d
abbr -a --position anywhere --function __abbr_subcommand_f -- f
abbr -a --position anywhere --function __abbr_subcommand_g -- g
abbr -a --position anywhere --function __abbr_subcommand_l -- l
abbr -a --position anywhere --function __abbr_subcommand_pl -- pl
abbr -a --position anywhere --function __abbr_subcommand_ps -- ps
abbr -a --position anywhere --function __abbr_subcommand_r -- r
abbr -a --position anywhere --function __abbr_subcommand_rs -- rs
abbr -a --position anywhere --function __abbr_subcommand_s -- s

if isatty
    set -x GPG_TTY (tty)
end

if not set -q TMUX
    exec tmux; or echo "failed to launch tmux"
end
