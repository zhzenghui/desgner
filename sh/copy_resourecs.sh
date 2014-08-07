#!/bin/bash

source info.sh 


echo "修改info.plist的CFBundleDisplayName"
defaults write $AppPlistPath "CFBundleDisplayName" $AppDisplayName


echo "display name:"
defaults write $AppPlistPath "CFBundleIdentifier" $AppBundleId



echo "copy icon images"
cp -R $icon_images_path $icon_path




echo "secuss"



