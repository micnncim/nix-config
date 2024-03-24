# function __abbr_subcommand_b
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "b" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "branch"
        return 0

    case '*'
        return 1
end
# end
