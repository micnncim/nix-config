# function __abbr_subcommand_f
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "f" ]
    return 1
end

switch "$cmd[1]"
    case "git"
        echo "fixup"
        return 0

    case '*'
        return 1
end
# end
