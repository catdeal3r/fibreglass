#!/bin/bash

battery_percent=$(cat /sys/class/power_supply/BAT0/capacity)
low_at=30
low_at_cache="Off"
should_charge=50
should_charge_cache="Off"

should_charge_func() {
  if [[ "$battery_percent" == "$should_charge" ]] && [[ $should_charge_cache == "Off" ]]; then
    notify-send --app-name "System" "Battery at 50%" "Maybe you wanna plug in a charger?"
    should_charge_cache="On"
  fi
  if [[ "49" -gt "$battery_percent" ]]; then
    should_charge_cache="Off"
  fi
}

low_at_func() {
  if [[ "$battery_percent" == "$low_at" ]] && [[ $low_at_cache == "Off" ]]; then
    notify-send --app-name "System" "Battery at 30%" "Please plug in a charger."
    low_at_cache="On"
  fi
  if [[ "29" -gt "$battery_percent" ]]; then
    low_at_cache="Off"
  fi
}

while true; do
  should_charge_func
  low_at_func
  echo "Waiting ..."
  sleep 1
done
