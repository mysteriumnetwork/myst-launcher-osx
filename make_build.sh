xcodebuild -configuration Release clean build -destination 'platform=macOS' -project "launcher.xcodeproj"

mv build/Release/ build/MysteriumLauncher
ln -s /Applications build/MysteriumLauncher/Applications

#hdiutil create -format UDZO -srcfolder build/MysteriumLauncher mysterium_launcher_macos.dmg
