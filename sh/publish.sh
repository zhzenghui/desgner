#!/bin/bash

source info.sh 



echo "创建production目录"
mkdir $production

echo "生成ipa包"

cd ..

# xcrun -sdk iphoneos packageapplication -v "$build/haidilao.app" -o "$production/$name$bundleShortVersion.ipa"
xcrun -sdk iphoneos packageapplication -v "/Users/lifeng/Desktop/ios/build/haidilao.app" -o /Users/lifeng/Desktop/ios/build



echo "生成ipa成功"


