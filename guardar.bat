@echo off
cd /d "%~dp0"
echo.
echo === GUARDANDO CAMBIOS EN GITHUB ===
echo.

git add .

git diff --cached --quiet
if %errorlevel% == 0 (
    echo No hay cambios nuevos para guardar.
    pause
    exit /b 0
)

echo Archivos a subir:
git diff --cached --name-only
echo.

set /p MSG="Descripcion del cambio (Enter para mensaje automatico): "
if "%MSG%"=="" (
    for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set FECHA=%%I
    set MSG=Actualizacion %FECHA:~0,4%-%FECHA:~4,2%-%FECHA:~6,2% %FECHA:~8,2%:%FECHA:~10,2%
)

git commit -m "%MSG%"
git push

echo.
echo === LISTO - Cambios guardados en GitHub ===
echo.
pause
