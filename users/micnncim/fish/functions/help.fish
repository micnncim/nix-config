# function help
if not count $argv > /dev/null
    echo "\
Show the command help with bat.

USAGE
    help <command>
" | bat --plain --language=help

    return 0
end

if not which $argv[1] > /dev/null
    echo "$argv[1] not found" >&2
    return 1
end

$argv --help 2>&1 | bat --plain --language=help

# end
