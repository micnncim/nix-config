# function __abbr_subcommand_s
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "s" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "status"
        return 0

    case '*'
        return 1
end
# end
