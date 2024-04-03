# function __abbr_subcommand_ab
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "ab" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "absorb"
        return 0

    case '*'
        return 1
end
# end
