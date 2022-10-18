@echo off

REM -------- build raylib.dll --------

set BASE=../raylib/src

clang -Oz -march=native -std=c99 -D_CRT_SECURE_NO_DEPRECATE ^
-fshort-wchar -fno-sanitize=undefined -finline-functions -ffast-math ^
-fno-stack-check -fno-stack-protector -fshort-wchar -flto ^
-DPLATFORM_DESKTOP -DBUILD_LIBTYPE_SHARED -DGRAPHICS_API_OPENGL_33 ^
-I "%BASE%" -I "%BASE%/external/glfw/include" ^
-c %BASE%/rcore.c %BASE%/rglfw.c %BASE%/rshapes.c %BASE%/rtextures.c %BASE%/rtext.c %BASE%/rmodels.c %BASE%/raudio.c %BASE%/utils.c

llvm-rc /FO raylib.res "%BASE%/raylib.dll.rc"

lld-link -dll -out:raylib.dll kernel32.lib user32.lib gdi32.lib winmm.lib shell32.lib libcmt.lib ^
raylib.res rcore.o rglfw.o rshapes.o rtextures.o rtext.o rmodels.o raudio.o utils.o

del *.o
del raylib.res


REM -------- build raygui.dll --------
copy ..\raygui\src\raygui.h raygui.c

clang -Oz -march=native -std=c99 -D_CRT_SECURE_NO_DEPRECATE ^
-fshort-wchar -fno-sanitize=undefined -finline-functions -ffast-math ^
-fno-stack-check -fno-stack-protector -fshort-wchar ^
-DBUILD_LIBTYPE_SHARED -DRAYGUI_IMPLEMENTATION ^
-shared -I "%BASE%" -o raygui.dll raygui.c raylib.lib

del raygui.c
