# function __abbr_flag_c
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "-c" ]
    return 1
end

switch "$cmd[1]"
    case "kubectl"
        echo "--context $(kubectl config current-context)"
        return 0

    case '*'
        return 1
end
# end
