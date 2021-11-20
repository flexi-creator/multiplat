# multiplat

A multi-platform app demonstrating responsive screens on the following platforms from a single Flutter codebase:
- Android
- iOS
- Web
- MacOS
- Windows
- Linux 

## Getting started with Flutter and this app
#### Deploy to Android / iOS
1. If you're deploying to Android / iOS, following these instructions: https://flutter.dev/docs/get-started/install
1. Open this project in Android Studio, IntelliJ or Visual Studio Code (not Xcode).
1. If you're deploying to iOS, on the command line run: pod install from the multiplat/ios folder to pick up the iOS plugins.
1. In one of the above-mentioned IDEs, press Play to build and start the app.

#### Deploy to the web
This app is available to deploy as a web app. The following lines are to be executed on your operating system's command line.
Ensure you're on the latest version of Flutter by switching to master and upgrading.
1. flutter channel master
1. flutter upgrade
1. flutter config --enable-web
1. Restart your Flutter IDE.
1. You can now select two different (but related) build targets: Chrome (web) and Web Server (web) Chrome deploys directly to a separate Chrome window. Select Web Server if you're testing on Firefox.
1. Uncomment code as per instructions in web_map_view.dart (must not check in uncommented as it will break non-web builds) This is to enable google maps for web build
1. Press Play to deploy to a web app.
1. The command line version of the web build is: flutter build web

#### Deploy to MacOS Desktop
This app is available to deploy as a standalone Mac app. The following lines are to be executed on the command line.
Ensure you're on the latest version of Flutter by switching to master and upgrading.
1. flutter channel master
1. flutter upgrade
1. flutter config --enable-macos-desktop 
1. Run: pod install from the multiplat/macos folder to update the macOS plugins.
1. Restart your Flutter IDE eg. Android Studio, Visual Studio Code
1. You can now select a different build target ie. macOS (desktop)
1. Press Play to build a standalone Mac app.
1. The command line version of the macos build is: flutter build macos

#### Deploy to Windows Desktop
The app is available as a standalone Windows app. This is considered experimental as the Flutter team do not recommend building production Windows apps at this stage, and library support is almost non-existent.
The following lines are to be executed on the Windows command line (cmd or PowerShell).
Ensure you're on the latest version of Flutter by switching to master and upgrading.
1. flutter channel master
1. flutter upgrade
1. flutter config --enable-windows-desktop 
1. flutter doctor and follow prompts to download Visual Studio community edition (not VS Code!) with the appropriate options to build Windows desktop apps.
1. There is IDE support for Flutter on Windows (you can download Android Studio for Windows), but in this README all flutter builds and runs will be performed from the command line.
1. The run command is: flutter run -d windows   (add -v to the end of this command if you need more info)

#### Deploy to Linux Desktop
The app is available as a standalone Linux app. This is considered experimental as there is very little documentation for linux desktop and library support is almost non-existent.
The following lines are to be executed on the linux command line.
Ensure you're on the latest version of Flutter by switching to master and upgrading.
The following has been tried on a clean installation of an Ubuntu 19.10 VM image running in VirtualBox.

Install dev tools required by flutter:
1. sudo apt-get install -y clang
1. sudo apt-get install -y git
1. sudo apt-get install -y curl
1. sudo apt-get install -y libx11-dev
1. sudo apt-get install -y libgtk-3-dev

As linux desktop flutter development is only supported on the master (bleeding edge) channel, it's faster to get the flutter SDK up and running via the flutter source code, so instead of downloading the flutter SDK binary, do the following:
1. git clone https://github.com/flutter/flutter.git
1. In your startup shell script eg. .bashrc add: export PATH=<path to your location of flutter/bin>:$PATH
1. flutter --version (this bootstraps the flutter SDK installation)
1. flutter config --enable-linux-desktop
1. flutter doctor (this downloads more flutter dev binaries and informs if you need download any further tools) 
1. There is IDE support for Flutter on Linux (you can download Android Studio for Linux), but in this README all flutter builds and runs will be performed from the command line.
1. The run command is: flutter run -d linux  (add -v to the end of this command if you need more info)

#### Linux app icon
The linux app icon is controlled by a separate .desktop file and is not automatically handled by the flutter build. This is an optional cosmetic step but allows a non-blank icon to appear when you launch the app and also allows you to pin the app to the linux dock.
1. Copy multiplat.desktop to ~/.local/share/applications/multiplat.desktop
1. Edit this text file and change the Exec and Icon entries to point to where you've placed the executable and icon files in case they're in a different location from the installation default / different login account.
