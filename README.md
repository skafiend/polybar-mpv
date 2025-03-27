https://imgur.com/a/rySBJvQ

- Before using the script make sure the file is executable and put the file to `~/.config/polybar/mpv.sh`:
```
chmod +x mpv.sh
```
- Create a new module in '~/.config/polybar/config.ini'
```

```

- create a wrapper script to launch mpv with a custom title to avoid triggering the module if you play videos, etc..
```
#!/bin/bash
if ! pgrep -f mpv_audiobook > /dev/null; then
    mpv --title="mpv_audiobook" --input-ipc-server=/tmp/mpvsocket --save-position-on-quit -no-video "$(cat ~/.config/mpv/curbook.tmp)" &
else
    pkill -f mpv_audiobook
fi
```
