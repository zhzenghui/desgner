
SRCROOT="/Users/lifeng/Documents/192.168.1.113/code/Designer"
RRoot="/Users/lifeng/快盘/我收到的共享文件/lifeng@i-bejoy.com/BEJOY项目文档/设计师App/07.黄珊珊/切图"
userPlistPath="$RRoot/user.plist"

production="$SRCROOT/production"
build="$SRCROOT/build"


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
# 版本
bundleShortVersion=$(/usr/libexec/PlistBuddy -c "print version" ${userPlistPath})

#模板
scheme="DesignerM1"

#本地ipa路径
ipa_path="$production/$AppName$bundleShortVersion.ipa"
server_ipa_path="root@223.4.147.79:/data/tomcat/webapps/ipa/dsg"

#sc/analysis/$AppName$bundleShortVersion.ipa

#--------------------------第一步修改plist信息----------------------------------------
# 修改 plist 的name，版本，
defaults write $AppPlistPath "CFBundleDisplayName" $AppDisplayName
defaults write $AppPlistPath "CFBundleIdentifier" $AppBundleId
# defaults write $AppPlistPath "CFBundleShortVersionString" $bundleShortVersion

#--------------------------第二步修改icon---------------------------------------------
echo "copy icon images"
cp -R $icon_images_path $icon_path
# 反馈


mkdir $production
cd ..

#--------------------------第三步编译项目-----------------------------------------------

echo "清理项目"
xcodebuild clean  CONFIGURATION_BUILD_DIR="$build"
echo "开始编译"
xcodebuild -configuration Release -workspace "$SRCROOT/Designer.xcworkspace"  -scheme "$scheme" CONFIGURATION_BUILD_DIR="$build"



#--------------------------第四步生成ipa-----------------------------------------------
echo "清理ipa目录"
rm -rf "$production/*"
echo "输出ipa"
xcrun -sdk iphoneos packageapplication -v "$build/$scheme.app" -o "$production/$AppName$bundleShortVersion.ipa"



# 上传服务器
scp  $ipa_path "$server_ipa_path/$AppName$bundleShortVersion.ipa"















