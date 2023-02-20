# function __abbr_subcommand_g
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "g" ]
    return 1
end

switch "$cmd[1]"
    case "kubectl"
        echo "get"
        return 0

    case '*'
        return 1
end
# end
