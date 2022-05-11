#!/bin/sh

# Set user key mappings suitable for US-international keyboard to get backtick/tilde on top left and backslash on bottom left
# - src 35, dst 64: upper left will emit backtick and tilde
# - src 64, dst 32: bottom left will emit backslash and vert
# - src 32, dst  35: left of enter will emit paragraph and plusminus

hidutil property --set '{"UserKeyMapping":[
    {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000064},
    {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000032},
    {"HIDKeyboardModifierMappingSrc":0x700000032,"HIDKeyboardModifierMappingDst":0x700000035},
]}'

# On my system, the mapping above works in reverse on the internal keyboard.
# Running the map in reverse seems to fix this:

# matches string for internal keyboard, e.g. {"VendorID":0x5ac,"ProductID":0x342}
# from https://gist.github.com/yuu/af5280e3142a6a14545b731b6ffa4597
target=`hidutil list |grep 'Apple Internal Keyboard' |head -n 1 |awk 'BEGIN{printf "\{%s","\"VendorID\":"} {printf "%s",$1} {printf "%s",","} {printf "%s","\"ProductID\":"} END{printf "%s\}\n",$2}'`

# match for internal keyboard
hidutil property --matching "${target}" --set '{"UserKeyMapping":[
    {"HIDKeyboardModifierMappingSrc":0x700000064,"HIDKeyboardModifierMappingDst":0x700000035},
    {"HIDKeyboardModifierMappingSrc":0x700000032,"HIDKeyboardModifierMappingDst":0x700000064},
    {"HIDKeyboardModifierMappingSrc":0x700000035,"HIDKeyboardModifierMappingDst":0x700000032},
]}'


