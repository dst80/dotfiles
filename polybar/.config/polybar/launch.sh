killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected " | cut -d" " -f1); do
    polybar bar_$m -c ~/.config/polybar/config &
  done
fi

