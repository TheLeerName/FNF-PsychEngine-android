# Building Psych Engine

## Android (from Windows)
1. Install [**Haxe 4.2.5**](https://haxe.org/download/version/4.2.5)
2. Install [**Git**](https://git-scm.com/downloads)
3. Do these commands in cmd:
```
haxelib install hxcpp 4.2.1
haxelib install lime 8.0.2
haxelib install openfl 9.2.2
haxelib install flixel 5.3.1
haxelib install flixel-tools 1.5.1
haxelib install flixel-ui 2.5.0
haxelib install flixel-addons 3.1.1
haxelib install hscript 2.5.0
haxelib install actuate 1.9.0
haxelib install hxCodec 2.5.1
haxelib install hxcpp-debug-server 1.2.4
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/TheLeerName/linc_luajit
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
```
4. Install [**JDK 11.0.0.1**](https://jdk.java.net/java-se-ri/11-MR2)
- Put folder in archive to `C:/Program Files/Java/`
5. Install [**Android NDK r15c**](https://github.com/android/ndk/wiki/Unsupported-Downloads#r15c)
- Put folder in archive to `%localappdata%/Android/`
6. Install [**Android Studio**](https://developer.android.com/studio)
- Start **Android Studio**
- Click three dots in right upper corner
- Click **SDK Manager**
- Choose `Android API 34`, `Android 9.0 (Pie)`
- Click **SDK Tools** tab
- Choose `Android SDK Build-Tools 34`, `Android Emulator` (if you want use emulator for checking app), `Android SDK Platform-Tools`
- Click **Apply**
- Click **OK**
- Wait and click **Finish**
7. Run command: `lime setup android`
- Enter `C:\Users\<username>\AppData\Local\Android\Sdk`
- Enter `C:\Users\<username>\AppData\Local\Android\android-ndk-r15c`
- Enter `C:\Program Files\Java\jdk-11.0.0.1`
8. And now compile it with: `lime test android -D NO_PRECOMPILED_HEADERS`

## Windows
1. Install [**Haxe 4.2.5**](https://haxe.org/download/version/4.2.5)
2. Install [**Git**](https://git-scm.com/downloads)
3. Do these commands in cmd:
```
haxelib install hxcpp 4.2.1
haxelib install lime 8.0.2
haxelib install openfl 9.2.2
haxelib install flixel 5.3.1
haxelib install flixel-tools 1.5.1
haxelib install flixel-ui 2.5.0
haxelib install flixel-addons 3.1.1
haxelib install hscript 2.5.0
haxelib install actuate 1.9.0
haxelib install hxCodec 2.5.1
haxelib install hxcpp-debug-server 1.2.4
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/TheLeerName/linc_luajit
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
```
4. Download [**VS Community**](https://visualstudio.microsoft.com/downloads/)
5. Open it and go to Individual Components tab
6. Download these libs:
```
MSVC v142 - C++ x64/x86 build tools
Windows SDK
```
7. And now compile it with: `lime test windows`

## Linux / Mac
1. Install [**Haxe 4.2.5**](https://haxe.org/download/version/4.2.5)
2. Install [**Git**](https://git-scm.com/downloads)
3. Do these commands in cmd:
```
haxelib install hxcpp 4.2.1
haxelib install lime 8.0.2
haxelib install openfl 9.2.2
haxelib install flixel 5.3.1
haxelib install flixel-tools 1.5.1
haxelib install flixel-ui 2.5.0
haxelib install flixel-addons 3.1.1
haxelib install hscript 2.5.0
haxelib install actuate 1.9.0
haxelib install hxCodec 2.5.1
haxelib install hxcpp-debug-server 1.2.4
haxelib git discord_rpc https://github.com/Aidan63/linc_discord-rpc
haxelib git linc_luajit https://github.com/TheLeerName/linc_luajit
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
```
4. And now compile it with: `lime test <linux/mac>`