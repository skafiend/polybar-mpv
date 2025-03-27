![no_image](https://github.com/skafiend/polybar-mpv/blob/main/image.png)

- Before using the script make it executable and put the file to `~/.config/polybar/`:
```
chmod +x mpv.sh
```
- Create a new module in '~/.config/polybar/config.ini'
```
[module/mpv-polybar]
type = custom/script
exec = ~/.config/polybar/mpv.sh
interval = 1
click-left = echo 'cycle pause' | socat - /tmp/mpvsocket
click-right = echo 'quit' | socat - /tmp/mpvsocket
```

- Create a wrapper script to launch mpv with a custom title to avoid triggering the module if you play videos, etc..
```
#!/bin/bash
if ! pgrep -f mpv_audiobook > /dev/null; then
    mpv --title="mpv_audiobook" --input-ipc-server=/tmp/mpvsocket --save-position-on-quit -no-video "$(cat ~/.config/mpv/curbook.tmp)" &
else
    pkill -f mpv_audiobook
fi
```
- In case you want to play around with colors https://github.com/polybar/polybar/wiki/Formatting#foreground-color-f
