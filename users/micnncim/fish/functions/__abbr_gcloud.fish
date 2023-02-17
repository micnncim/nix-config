# function __abbr_gcloud
set -l cmd (commandline -op)

if [ "$cmd[1]" != "gcloud" ]
    return 1
end

switch "$cmd[-1]"
    case "-p"
        echo "--project="
    case "*"
        return 1
end
# end
