#!/bin/bash

SRCROOT="/Users/lifeng/Documents/192.168.1.113/code/Designer"
RRoot="/Users/lifeng/快盘/我收到的共享文件/lifeng@i-bejoy.com/BEJOY项目文档/设计师App/10.刘强/切图"
userPlistPath="$RRoot/user.plist"



icon_path="$SRCROOT/Designer/Images.xcassets/AppIcon.appiconset/icon-152x152.png"
icon_images_path="$RRoot/icon/icon-152x152.png"

#程序名称
AppName=$(/usr/libexec/PlistBuddy -c "print name" ${userPlistPath})

AppBundleId="com.i-bejoy.$AppName"
#显示名
AppDisplayName=$(/usr/libexec/PlistBuddy -c "print display_name" ${userPlistPath})
# plist
AppPlistName=$(/usr/libexec/PlistBuddy -c "print plist" ${userPlistPath})

AppPlistPath="$SRCROOT/Designer/$AppPlistName.plist"






appname "Designer"

build="$SRCROOT/build"







