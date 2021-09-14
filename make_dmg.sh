#sudo xcode-select --switch /Library/Developer/CommandLineTools
#sudo xcode-select -s /Users/macmini/Downloads/Xcode.app/Contents/Developer

xcodebuild ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO clean build -destination 'platform=macOS' -project "launcher.xcodeproj"
hdiutil create -format UDZO -srcfolder build/Release myst_launcher.dmg

#xcodebuild archive -archivePath archive/result.xcarchive -scheme launcher -configuration "Release" ARCHS="x86_64h" -destination 'platform=macOS' -project "launcher.xcodeproj"
#xcodebuild archive -archivePath archive/result.xcarchive -exportArchive -exportOptionsPlist exportOptionsAdHoc.plist -exportPath app
