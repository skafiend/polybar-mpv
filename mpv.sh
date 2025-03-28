#!/bin/bash
_print_time() {
    printf '%s%2d:%02d:%02d' "$1" "$2" "$3" "$4" 
}

SOCK='/tmp/mpvsocket'
(
    metadata=$(echo '{ "command": ["get_property", "media-title"] }' | socat - $SOCK | jq -r .data) 
    position=$(echo '{ "command": ["get_property_string", "time-pos"] }' | socat - $SOCK  | jq -r .data | cut -d'.' -f 1) 
    remaining=$(echo '{ "command": ["get_property_string", "duration"] }' | socat - $SOCK | jq -r .data | cut -d'.' -f 1) 
    ERROR=$(</tmp/mpv_book_error)
    if [ -z $ERROR ]; then 
        echo -n "%{F$PRIMARY_COLOR} " 
        if [ ${#metadata} -gt 55 ]; then
            printf '%.55s' "$metadata..."
        else
            printf "$metadata"
        fi
        _print_time "%{F#fff}" $((position/3600)) $((position%3600/60)) $((position%60)) %{F-}
        echo -n " %{F$PRIMARY_COLOR}/%{F-}"
        _print_time "" $((remaining/3600)) $((remaining%3600/60)) $((remaining%60))
        echo -n " %{F$PRIMARY_COLOR}|"
    else 
        echo ""
    fi
) 2> /tmp/mpv_book_error
