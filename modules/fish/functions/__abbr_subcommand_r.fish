# function __abbr_subcommand_r
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "r" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "remote"
        return 0

    case '*'
        return 1
end
# end
