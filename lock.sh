#!/bin/bash

# Use x rand to get the horizontal position of the monitors
monitors=$(xrandr --listmonitors | grep -v "Monitors" | sed  's/^.*+\([0-9]*\)+.*/\1/g')

# Save the WD of the command to launch vikmatrix
VIKMATRIXDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

SAVEIFS=$IFS   # Save current IFS
IFS=$'\n'      # Change IFS to new line
monitors=($monitors) # split to array $monitors
IFS=$SAVEIFS   # Restore IFS

for (( i=0; i<${#monitors[@]}; i++ ))
do
    # Spawn a gnome terminal in each screen with "--full-screen" 
    gnome-terminal --full-screen --geometry "1x1+${monitors[$i]}+0" -e "$VIKMATRIXDIR/vikmatrix.sh" &
done

# Lock the screen and wait until unlocked to kill spawned terminals
pyxtrlock; pgrep vikmatrix | xargs kill
