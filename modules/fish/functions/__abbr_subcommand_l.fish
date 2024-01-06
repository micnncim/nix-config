# function __abbr_subcommand_l
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "l" ]
    return 1
end

switch "$cmd[1]"
    case "gcloud"
        echo "list"
        return 0

    case '*'
        return 1
end
# end
