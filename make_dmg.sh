xcodebuild ARCHS=x86_64 ONLY_ACTIVE_ARCH=NO clean build -destination 'platform=macOS' -project "launcher.xcodeproj"
hdiutil create -format UDZO -srcfolder build/Release myst_launcher_macos_amd64.dmg

