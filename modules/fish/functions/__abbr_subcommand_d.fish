# function __abbr_subcommand_d
set -l cmd (commandline -op)

if [ "$cmd[-1]" != "d" ]
    return 1
end

switch "$cmd[1]"
    case "gcloud"
        echo "describe"
        return 0

    case "kubectl"
        echo "describe"
        return 0

    case '*'
        return 1
end
# end
