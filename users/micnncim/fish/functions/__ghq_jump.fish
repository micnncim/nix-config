# function __ghq_jump
ghq list | fzf | read dir

if [ $dir ]
    # Ref: https://github.com/fish-shell/fish-shell/issues/6413
    cd (ghq root)/$dir; commandline -f repaint; clear
end
# end
