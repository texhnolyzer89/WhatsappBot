#!/bin/bash

db_file="ace.db"
db_bk_file="ace_bk.db"
csv_file="file.csv"
# SQLite table name
table_name="numbers"

# CSV delimiter (e.g., comma)
delimiter=","

# Insert CSV data into sqlite DB
#awk -v table="$table_name" -v delimiter="$delimiter" '
#BEGIN {
#    FS = delimiter;
#    getline; # Skip the header line if your CSV has one
#}
#{
#    gsub(/"/, "\"\"", $3); # Handle double quotes by escaping them in the third column
#    printf "INSERT INTO \"%s\" (number, messaged) VALUES (\"%s\", 0);\n", table, $3;
#}' "$csv_file" | sqlite3 "$db_file"

query="SELECT id, number, messaged FROM numbers WHERE messaged = '0'"

sqlite3 "$db_file" "$query" | while IFS="|" read -r id number messaged; do
    echo "ID: $id, Message: $number, Messaged: $messaged"

    echo $number | xclip -selection clipboard
    # Open chat button
    xdotool mousemove 310 80
    xdotool click 1
    sleep 2
    # Send phone number
    xdotool mousemove 310 200
    xdotool click 1
    xdotool type "$(xclip -o -selection clipboard)"
    sleep 2
    xdotool mousemove 310 310
    sleep 2

    scrot /tmp/copycolor.png
    IMAGE=$(convert /tmp/copycolor.png -depth 8 -crop 1x1+310+310 txt:-)
    color=$(echo $IMAGE | grep -om1 '#\w\+')
    rm /tmp/copycolor.png

    if [ "$color" = "#F5F6F6" ]; then
        xdotool click 1
        sleep 2
        #xclip -selection c < video.mp4
        #sleep 5
        #xdotool key Ctrl+V
        #sleep 2
        echo "STANDARD MESSAGE" | xclip -selection clipboard
        sleep 2
        xdotool type "$(xclip -o -selection clipboard)"
        sleep 2
        xdotool key Shift+Return
        xdotool key Shift+Return
        echo "LORIS IPSUM DOLOR" | xclip -selection clipboard
        sleep 2
        xdotool type "$(xclip -o -selection clipboard)"
        sleep 1
        xdotool key Return

    elif [ "$color" = "#F0F2F5" ]; then
        echo "Number not found"
    fi

    sleep 2

    # Go back
    xdotool mousemove 100 130
    xdotool click 1
    sleep 2

    # Update the flag to 'true' in the database
    update_query="UPDATE numbers SET messaged = '1' WHERE id = $id"
    sqlite3 "$db_bk_file" "$update_query"

    echo "Flag updated to 'true' for ID: $id"
done
