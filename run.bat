@echo off

:: Elimina los archivos de la compilacion anterior
cd Out
del /s *.prg *.lst *.map *.lbl *.dbg *.vice
cd ..

:: Compila
cl65 -g -t c64 -C c64-asm.cfg -u __EXEHDR__ %1/%1.s -Ln Out/%1.lbl -v -m Out/%1.map -o Out/%1.prg

:: Elimina el archivo objeto
del /s %1\%1.o

:: Si error - sale
if %errorlevel% neq 0 exit /b %errorlevel%

:: Ejecuta emulador y carga el programa
x64 Out\%1.prg
