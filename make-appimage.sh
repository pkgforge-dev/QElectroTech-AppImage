#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q qelectrotech | awk '{print $2; exit}') # example command to get version of application here
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.bg.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/128x128/apps/qelectrotech.png
export DESKTOP=/usr/share/applications/qelectrotech.desktop

# Deploy dependencies
quick-sharun /usr/bin/qelectrotech /usr/share/qelectrotech

# The gtk3 plugin does not change the look of the app for some reason
# this bug also hapens in the native distro package
rm -f ./AppDir/lib/qt/plugins/platformthemes/libqgtk3.so

# Turn AppDir into AppImage
quick-sharun --make-appimage
