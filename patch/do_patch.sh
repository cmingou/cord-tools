#!/bin/bash
cp $HOME/cord-tools/patch/patch_Vagrantfile $HOME/opencord/build
cp $HOME/cord-tools/patch/patch_config $HOME/opencord/build
cp $HOME/cord-tools/patch/patch_platform $HOME/opencord/build/platform-install
cp $HOME/cord-tools/patch/patch_maas $HOME/opencord/build/maas

cd $HOME/opencord/build/
git apply patch_config
cat patch_config
git apply patch_Vagrantfile
cat patch_Vagrantfile

cd $HOME/opencord/build/platform-install
git apply patch_platform
cat patch_platform

cd $HOME/opencord/build/maas
git apply patch_maas
cat patch_maas
