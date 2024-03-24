# function __abbr_subcommand_rs
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "rs" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "reset"
        return 0

    case '*'
        return 1
end
# end
