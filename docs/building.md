# Building Psych Engine

## Android
coming soon (i need fix it)

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
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
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
haxelib git linc_luajit https://github.com/superpowers04/linc_luajit
haxelib run lime setup
haxelib run lime setup flixel
haxelib run flixel-tools setup
```
4. And now compile it with: `lime test <linux/mac>`