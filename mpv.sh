#!/bin/bash
_print_time() {
    printf '%s%d:%02d:%02d' "$1" "$2" "$3" "$4" 
}
# mpv --title="mpv_audiobook" --input-ipc-server=/tmp/mpvsocket --save-position-on-quit -no-video "$(cat ~/.config/mpv/curbook.tmp)" &
if pgrep -f "mpv_audiobook" > /dev/null; then
    SOCK='/tmp/mpvsocket'
    (
    metadata=$(echo '{ "command": ["get_property", "media-title"] }' | socat - $SOCK | jq -r .data) 
    position=$(echo '{ "command": ["get_property_string", "time-pos"] }' | socat - $SOCK  | jq -r .data | cut -d'.' -f 1) 
#     jq extracts the number from 
#     {"data":"8976.666122","request_id":0,"error":"success"}
#     and cut using "." as a delimiter and "rounds up" the result
    remaining=$(echo '{ "command": ["get_property_string", "duration"] }' | socat - $SOCK | jq -r .data | cut -d'.' -f 1) 
    ERROR=$(</tmp/mpv_book_error)
    if [ -z $ERROR ]; then 
        _print_time "%{F#fff}" $((position/3600)) $((position%3600/60)) $((position%60)) %{F-}
        echo -n "%{F$PRIMARY_COLOR} " 
        printf '%s' "$metadata"
        _print_time "%{F#fff} " $((remaining/3600)) $((remaining%3600/60)) $((remaining%60)) 
        echo -n " %{F$PRIMARY_COLOR}|%{F-}" 
    else 
        echo ""
    fi
) 2> /tmp/mpv_book_error
else
    echo ""
fi


