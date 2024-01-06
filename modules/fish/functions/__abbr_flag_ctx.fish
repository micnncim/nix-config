# function __abbr_flag_ctx
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "-ctx" ]
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
