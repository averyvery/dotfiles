function fish_right_prompt
    type -q ccusage; or return

    set -l cache /tmp/ccusage-today-$USER
    # Refresh at most once a minute, in the background, so the prompt never waits on ccusage
    if not test -f $cache; or test (math (date +%s) - (stat -f %m $cache)) -gt 60
        command fish -c "ccusage daily --json --since (date +%Y%m%d) 2>/dev/null | jq -r '.totals.totalTokens // 0' > $cache.tmp; and mv $cache.tmp $cache" &>/dev/null &
        disown
    end

    test -f $cache; or return
    set -l tokens (cat $cache)
    test -n "$tokens"; and test "$tokens" -gt 0; or return

    if test $tokens -ge 1000000
        set tokens (math -s1 $tokens / 1000000)M
    else if test $tokens -ge 1000
        set tokens (math -s1 $tokens / 1000)k
    end

    set_color brblack
    echo -n $tokens
    set_color normal
end
