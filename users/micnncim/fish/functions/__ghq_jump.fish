# function __ghq_jump
ghq list | fzf | read dir

if [ $dir ]
    cd (ghq root)/$dir
end
# end
