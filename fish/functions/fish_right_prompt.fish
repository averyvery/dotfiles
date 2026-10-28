function __ccusage_fmt --argument-names n
    if test $n -ge 1000000
        echo (math -s1 $n / 1000000)M
    else if test $n -ge 1000
        echo (math -s1 $n / 1000)k
    else
        echo $n
    end
end

function fish_right_prompt
    type -q ccusage; or return
    type -q jq; or return

    set -l cache /tmp/ccusage-block-$USER
    # Refresh at most once a minute, in the background, so the prompt never waits on ccusage
    if not test -f $cache; or test (math (date +%s) - (stat -f %m $cache)) -gt 60
        command fish -c "ccusage blocks --json 2>/dev/null | jq -r '
            [.blocks[] | select(.isGap | not)] as \$b
            | ((\$b | map(select(.isActive)) | first | .totalTokens) // 0) as \$used
            | ((\$b | map(select(.isActive | not) | .totalTokens) | max) // 0) as \$max
            | \"\(\$used) \(\$max)\"
        ' > $cache.tmp; and mv $cache.tmp $cache" &>/dev/null &
        disown
    end

    test -f $cache; or return
    set -l parts (string split ' ' -- (cat $cache))
    test (count $parts) -eq 2; or return
    string match -qr '^\d+$' -- $parts[1] $parts[2]; or return

    set -l used (__ccusage_fmt $parts[1])
    set -l out $used
    if test $parts[2] -gt 0
        set out "$used / "(__ccusage_fmt $parts[2])
    end

    set_color brblack
    echo -n $out
    set_color normal
end
