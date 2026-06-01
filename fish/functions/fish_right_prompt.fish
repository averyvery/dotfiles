function fish_right_prompt
    set_color brblack
    set -l stats (claude-stats 2>/dev/null | string replace ' tok' '')
    set -l time (date '+%H:%M:%S')
    if set -q CMD_DURATION; and test $CMD_DURATION -gt 0
        if test $CMD_DURATION -lt 1000
            echo -n "$stats | $CMD_DURATION"ms" | $time"
        else
            echo -n "$stats | "(math -s1 $CMD_DURATION / 1000)"s | $time"
        end
    else
        echo -n "$stats | $time"
    end
    set_color normal
end
