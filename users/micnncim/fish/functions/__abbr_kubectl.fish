# function __abbr_kubectl
set -l cmd (commandline -op)

if [ "$cmd[1]" != "kubectl" ]
    return 1
end

switch "$cmd[2]"
    case "g"
        echo "get"
        return 0
    case "d"
        echo "describe"
        return 0
end

switch "$cmd[-1]"
    case "-c"
        echo "--context $(kubectl config current-context)"
        return 0
    case "-n"
        echo "-n $(kubectl config view --minify -o jsonpath='{..namespace}')"
        return 0
end

return 1
# end
