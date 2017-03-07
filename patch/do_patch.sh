#!/bin/bash
cp $HOME/patch/patch_config $HOME/opencord/build
cp $HOME/patch/patch_platform $HOME/opencord/build/platform-install


cd $HOME/opencord/build/
git apply patch_config
cat patch_config

cd $HOME/opencord/build/platform-install
git apply patch_platform
cat patch_platform
