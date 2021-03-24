:: Copyright (C) 2020 Oplus. All rights reserved.
adb root
adb remount
adb shell umount -lf /vendor/lib64
adb shell umount -lf /vendor/lib
cd lib
adb push . /vendor/lib
adb push . /system/lib
cd ..\lib64
adb push . /vendor/lib64
adb push . /system/lib64
cd ..

pause