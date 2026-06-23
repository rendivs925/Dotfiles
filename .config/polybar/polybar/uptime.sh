#!/bin/bash

output=$(uptime -p)
output="${output/up/UP}"
output="${output/up/UP}"
echo "%{F#47FF9C}UP%{F-}${output#UP}"
