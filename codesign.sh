MACOS_CERTIFICATE_ID="(KPKW2HX458)"

/usr/bin/codesign --force -s "$MACOS_CERTIFICATE_ID" --timestamp ./build/MysteriumLauncher/Mysterium\ Node\ Launcher.app/Contents/MacOS/Mysterium\ Node\ Launcher
/usr/bin/codesign --force -s "$MACOS_CERTIFICATE_ID" --timestamp -o runtime ./build/MysteriumLauncher/Mysterium\ Node\ Launcher.app/Contents/Frameworks/gobridge.dylib

#hdiutil create -format UDZO -srcfolder build/MysteriumLauncher mysterium_launcher_macos_amd64.dmg
