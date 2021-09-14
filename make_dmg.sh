xcodebuild ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO clean build -destination 'platform=macOS' -project "launcher.xcodeproj"

rm -rf build/Release/Launcher.app.dSYM
mv build/Release/ build/MystLauncher
ln -s /Applications build/MystLauncher/Applications

hdiutil create -format UDZO -srcfolder build/MystLauncher myst_launcher_macos_amd64.dmg

