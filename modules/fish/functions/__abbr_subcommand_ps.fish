# function __abbr_subcommand_ps
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "ps" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "push"
        return 0

    case '*'
        return 1
end
# end
