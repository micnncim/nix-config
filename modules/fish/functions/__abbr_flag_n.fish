# function __abbr_flag_n
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "-n" ]
    return 1
end

switch "$cmd[1]"
    case "kubectl"
        echo "-n $(kubectl config view --minify -o jsonpath='{..namespace}')"
        return 0

    case '*'
        return 1
end
# end
