# function __abbr_flag_p
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "-o" ]
    return 1
end

switch "$cmd[1]"
    case "kubectl"
        echo "-o yaml"
        return 0

    case '*'
        return 1
end
# end
