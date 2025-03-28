![no_image](https://github.com/skafiend/polybar-mpv/blob/main/example.png)

It's a slightly edited version of the script from https://www.reddit.com/r/Polybar/comments/cqj7jt/couldnt_find_much_on_a_module_for_mpv_so_i_made/
I just added colors and errors handling.

- Before using the script make it executable and put the file to `~/.config/polybar/`:
```
chmod +x mpv.sh
```
- Create a new module in '~/.config/polybar/config.ini'
```
[module/mpv]
type = custom/script
exec = ~/.config/polybar/mpv.sh
exec-if = pgrep -f mpv_audiobook
tail = true
interval = 1
click-left = echo 'cycle pause' | socat - /tmp/mpvsocket
click-right = echo 'quit' | socat - /tmp/mpvsocket
scroll-up = echo 'add volume +10' | socat - /tmp/mpvsocket
scroll-down = echo 'add volume -10' | socat - /tmp/mpvsocket
```

- Create a wrapper script to launch mpv with a custom title to avoid triggering the module if you play videos, etc.. 
```
#!/bin/bash
if ! pgrep -f mpv_audiobook > /dev/null; then
    mpv --title="mpv_audiobook" \
        --input-ipc-server=/tmp/mpvsocket \
        --save-position-on-quit \
        -no-video \
        "$1" &
else
    pkill -f mpv_audiobook
fi
```
If you don't want to use the wrapper at least add `mpv --input-ipc-server=/tmp/mpvsocket`
- In case you want to play around with colors https://github.com/polybar/polybar/wiki/Formatting#foreground-color-f
