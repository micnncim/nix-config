# function __abbr_subcommand_pl
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "pl" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "pull"
        return 0

    case '*'
        return 1
end
# end
