#!/bin/bash
#Download original cord-in-a-box script
curl --compressed -o ~/cord-in-a-box.sh https://raw.githubusercontent.com/opencord/cord/cord-2.0/scripts/cord-in-a-box.sh

#patch cord-in-a-box script
cp $(dirname $0)/patch/patch_ciab ~/
cd ~/
git apply patch_ciab
rm patch_ciab
