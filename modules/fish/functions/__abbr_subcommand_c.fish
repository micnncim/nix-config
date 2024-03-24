# function __abbr_subcommand_c
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "c" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "commit -s"
        return 0

    case '*'
        return 1
end
# end
