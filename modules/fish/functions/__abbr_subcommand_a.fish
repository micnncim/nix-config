# function __abbr_subcommand_a
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "a" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "add"
        return 0

    case '*'
        return 1
end
# end
