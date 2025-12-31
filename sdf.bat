@echo off
REM ============================================
REM Script COMPLETO de limpieza FiveM
REM Incluye: Desvincular Steam, Rockstar, Xbox
REM ============================================
title Limpiador FiveM - Desvincular Cuentas
color 0A
setlocal enabledelayedexpansion

echo #########################################
echo #    LIMPIADOR COMPLETO - CUENTAS       #
echo #########################################
echo.
echo ADVERTENCIA: Este script realizara:
echo 1. Desvincular cuenta de Steam
echo 2. Desvincular cuenta de Rockstar Games
echo 3. Detener servicios de Xbox
echo 4. Borrar cache de FiveM
echo 5. NO desvincula Epic Games
echo.
echo Esto cerrara sesion en todos los servidores.
echo.

set /p confirm="¿Estas SEGURO que quieres continuar? (SI/NO): "
if /i not "%confirm%"=="SI" (
    echo Operacion cancelada.
    pause
    exit /b 1
)

echo.
echo [1/6] Deteniendo servicios y procesos...
echo.

REM --- Detener servicios de Xbox ---
echo Deteniendo servicios de Xbox...
sc stop XblAuthManager >nul 2>&1
sc stop XblGameSave >nul 2>&1
sc stop XboxGipSvc >nul 2>&1
sc stop XboxNetApiSvc >nul 2>&1
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
sc config XboxGipSvc start= disabled >nul 2>&1
sc config XboxNetApiSvc start= disabled >nul 2>&1
echo Servicios de Xbox detenidos y deshabilitados.

REM --- Cerrar procesos relacionados ---
echo Cerrando procesos...
taskkill /f /im Steam.exe /t >nul 2>&1
taskkill /f /im EpicGamesLauncher.exe /t >nul 2>&1
taskkill /f /im RockstarService.exe /t >nul 2>&1
taskkill /f /im SocialClubHelper.exe /t >nul 2>&1
taskkill /f /im FiveM.exe /t >nul 2>&1
timeout /t 3 /nobreak >nul

echo.
echo [2/6] Desvinculando cuenta de Steam...
echo.

REM --- Desvincular Steam de FiveM ---
set "STEAM_DATA=%LocalAppData%\FiveM\FiveM.app\data\storage\steam"
if exist "!STEAM_DATA!" (
    echo Eliminando datos de Steam...
    rmdir /s /q "!STEAM_DATA!" 2>nul
    echo ✓ Steam desvinculado de FiveM
) else (
    echo No se encontraron datos de Steam
)

REM --- Borrar token de Steam si existe ---
set "STEAM_TOKEN=%LocalAppData%\FiveM\FiveM.app\data\cache\steam_token"
if exist "!STEAM_TOKEN!.*" (
    del /q /f "!STEAM_TOKEN!.*" 2>nul
)

echo.
echo [3/6] Desvinculando cuenta de Rockstar Games...
echo.

REM --- Eliminar datos de Rockstar/Social Club ---
set "ROCKSTAR_PATHS="
set "ROCKSTAR_PATHS=!ROCKSTAR_PATHS! "%LocalAppData%\FiveM\FiveM.app\data\storage\ros""
set "ROCKSTAR_PATHS=!ROCKSTAR_PATHS! "%LocalAppData%\FiveM\FiveM.app\data\storage\rockstar""
set "ROCKSTAR_PATHS=!ROCKSTAR_PATHS! "%LocalAppData%\FiveM\FiveM.app\data\cache\ros""
set "ROCKSTAR_PATHS=!ROCKSTAR_PATHS! "%LocalAppData%\FiveM\FiveM.app\data\cache\rockstar""
set "ROCKSTAR_PATHS=!ROCKSTAR_PATHS! "%AppData%\Rockstar Games""
set "ROCKSTAR_PATHS=!ROCKSTAR_PATHS! "%LocalAppData%\Rockstar Games""

for %%p in (!ROCKSTAR_PATHS!) do (
    if exist %%p (
        echo Eliminando: %%p
        rmdir /s /q %%p 2>nul
    )
)

REM --- Borrar archivos específicos de Rockstar ---
del /q /f "%LocalAppData%\FiveM\FiveM.app\data\storage\*rockstar*" 2>nul
del /q /f "%LocalAppData%\FiveM\FiveM.app\data\storage\*ros*" 2>nul
del /q /f "%LocalAppData%\FiveM\FiveM.app\data\cache\*rockstar*" 2>nul
del /q /f "%LocalAppData%\FiveM\FiveM.app\data\cache\*ros*" 2>nul

echo ✓ Rockstar Games desvinculado

echo.
echo [4/6] Limpiando cache de FiveM...
echo.

REM --- Limpiar cache principal ---
set "FIVEM_CACHE=%LocalAppData%\FiveM\FiveM.app\cache"
if exist "!FIVEM_CACHE!" (
    echo Eliminando cache completo...
    rmdir /s /q "!FIVEM_CACHE!" 2>nul
    mkdir "!FIVEM_CACHE!" 2>nul
    echo ✓ Cache eliminado
)

REM --- Limpiar subcarpetas de cache ---
set "CACHE_FOLDERS=authbrowser Browser db dunno priv servers subprocess unconfirmed"
for %%f in (!CACHE_FOLDERS!) do (
    if exist "%LocalAppData%\FiveM\FiveM.app\cache\%%f" (
        rmdir /s /q "%LocalAppData%\FiveM\FiveM.app\cache\%%f" 2>nul
    )
)

echo.
echo [5/6] Eliminando logs y archivos temporales...
echo.

REM --- Eliminar logs ---
if exist "%LocalAppData%\FiveM\FiveM.app\logs" (
    del /q /f "%LocalAppData%\FiveM\FiveM.app\logs\*.*" 2>nul
    echo Logs eliminados
)

REM --- Eliminar crash reports ---
if exist "%LocalAppData%\FiveM\FiveM.app\crashes" (
    del /q /f "%LocalAppData%\FiveM\FiveM.app\crashes\*.*" 2>nul
    echo Crash reports eliminados
)

REM --- Eliminar archivos temporales adicionales ---
del /q /f "%LocalAppData%\FiveM\FiveM.app\*.tmp" 2>nul
del /q /f "%LocalAppData%\FiveM\FiveM.app\*.log" 2>nul
del /q /f "%LocalAppData%\FiveM\FiveM.app\cache\*.json" 2>nul
del /q /f "%LocalAppData%\FiveM\FiveM.app\cache\*.dat" 2>nul

REM --- Eliminar DigitalEntitlements ---
if exist "%LocalAppData%\DigitalEntitlements" (
    rmdir /s /q "%LocalAppData%\DigitalEntitlements" 2>nul
    echo DigitalEntitlements eliminado
)

echo.
echo [6/6] Limpieza final y resumen...
echo.

REM --- Recrear estructura básica ---
mkdir "%LocalAppData%\FiveM\FiveM.app\cache" 2>nul
mkdir "%LocalAppData%\FiveM\FiveM.app\logs" 2>nul
mkdir "%LocalAppData%\FiveM\FiveM.app\crashes" 2>nul

echo ============================================
echo LIMPIEZA COMPLETADA EXITOSAMENTE
echo.
echo ACCIONES REALIZADAS:
echo ✓ Servicios de Xbox detenidos y deshabilitados
echo ✓ Cuenta de Steam desvinculada de FiveM
echo ✓ Cuenta de Rockstar Games desvinculada
echo ✓ Cache completo de FiveM eliminado
echo ✓ Logs y crash reports borrados
echo ✓ Archivos temporales limpiados
echo.
echo NOTAS IMPORTANTES:
echo 1. Epic Games NO fue desvinculada (como solicitaste)
echo 2. La proxima vez que abras FiveM:
echo    - Tendras que iniciar sesion en Steam
echo    - Tendras que iniciar sesion en Rockstar
echo    - Se descargara cache nuevamente (~1-2GB)
echo 3. Los servicios de Xbox permaneceran deshabilitados
echo ============================================
echo.

REM --- Opción para habilitar Xbox de nuevo ---
set /p enableXbox="¿Deseas habilitar los servicios de Xbox? (SI/NO): "
if /i "!enableXbox!"=="SI" (
    echo Habilitando servicios de Xbox...
    sc config XblAuthManager start= demand >nul 2>&1
    sc config XblGameSave start= demand >nul 2>&1
    sc config XboxGipSvc start= demand >nul 2>&1
    sc config XboxNetApiSvc start= demand >nul 2>&1
    echo ✓ Servicios de Xbox habilitados
)

echo.
echo Proceso completado. Presiona cualquier tecla para salir...
pause >nul
