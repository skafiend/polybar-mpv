- Before using the script make sure the file is executable:
```
chmod +x mpv.sh
```
- create a wrapper script to lauch mpv
```
#!/bin/bash
if ! pgrep -f mpv_audiobook > /dev/null; then
    mpv --title="mpv_audiobook" --input-ipc-server=/tmp/mpvsocket --save-position-on-quit -no-video "$(cat ~/.config/mpv/curbook.tmp)" &
	pkill cmus
else
	pkill -f mpv_audiobook
fi
```
