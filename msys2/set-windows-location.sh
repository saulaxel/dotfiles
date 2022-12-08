LOCATION_FILE="location.txt"

if [ -f "$LOCATION_FILE" ]; then
    windows_style_path="$(iconv -f CP437 -t UTF-8 $LOCATION_FILE)"
    rm "$LOCATION_FILE"

    drive_letter=${windows_style_path:1:1}
    unix_style_path=${windows_style_path:3:-2}
    unix_style_path="/${drive_letter}${unix_style_path//\\/\/}"
    cd "$unix_style_path"
else
    cd /c/Users/saula/Documents/
fi
