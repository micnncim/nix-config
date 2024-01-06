# function fkill
procs -c always | fzf --header-lines 2 --ansi | awk '{print $1}' | while read -l pid
    kill $pid
end
# end
