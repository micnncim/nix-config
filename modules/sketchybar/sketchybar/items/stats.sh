#!/bin/bash

stats=(
  background.padding_left=-5
  background.padding_right=-5
  alias.color="$LABEL_COLOR"
  alias.update_freq=15
)

sketchybar --add alias "Stats,CPU_mini" right \
  --set "Stats,CPU_mini" "${stats[@]}"

sketchybar --add alias "Stats,RAM_mini" right \
  --set "Stats,RAM_mini" "${stats[@]}"
