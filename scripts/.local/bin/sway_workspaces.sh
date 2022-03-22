#!/usr/bin/env bash

mapfile -t MONITORS < <(swaymsg -t get_outputs | jq '.[] | (.make + " " + .model + " " + .serial)')

if [[ ${#MONITORS[@]} -eq 3 ]]; then
	MONITORS=(${MONITORS:1})
fi
if [[ ${#MONITORS[@]} -eq 2 ]]; then
	for ws in 1 2 3; do workspace $ws output "${MONITORS[0]}"; done
	for ws in 4 5 6; do workspace $ws output "${MONITORS[1]}"; done
fi

