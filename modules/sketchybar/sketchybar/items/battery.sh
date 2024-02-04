#!/bin/bash

battery=(
  background.padding_left=0
  background.padding_right=0
  alias.color="$LABEL_COLOR"
  alias.update_freq=15
)

sketchybar --add alias "Stats,Battery_battery" right \
  --set "Stats,Battery_battery" "${battery[@]}"
