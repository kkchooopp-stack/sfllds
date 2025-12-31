@echo off

:: ==============================================
:: MODIFICACIONES REALIZADAS:
:: 1. Quitadas todas las referencias a instalación de software
:: 2. Eliminados los comandos para desinstalar/instalar programas
:: 3. Quitadas rutas específicas de usuario (S-1-5-21-...)
:: 4. Quitados comandos de eliminación de directorios
:: ==============================================

:: --- Cerrar procesos (mantenido si aún lo necesitas) ---
taskkill /f /im "EpicGamesLauncher.exe" /t /fi "status eq running">nul 2>&1
taskkill /f /im "FortniteLauncher.exe" /t /fi "status eq running">nul 2>&1
taskkill /f /im "FortniteClient-Win64-Shipping_BE.exe" /t /fi "status eq running">nul 2>&1
taskkill /f /im "FortniteClient-Win64-Shipping.exe" /t /fi "status eq running">nul 2>&1
taskkill /f /im "EasyAntiCheat.exe" /t /fi "status eq running">nul 2>&1

:: --- Limpieza de registro Epic Games (sin rutas de usuario específicas) ---
reg delete "HKEY_CURRENT_USER\Software\Epic Games" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\WOW6432Node\Epic Games" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Classes\com.epicgames.launcher" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Epic Games\Unreal Engine\Identifiers" /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Epic Games\Unreal Engine\Hardware Survey" /f >nul 2>&1

reg delete "HKEY_CLASSES_ROOT\com.epicgames.launcher" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\com.epicgames.launcher" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Epic Games" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\EpicGames" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\EpicGames" /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Epic Games" /f >nul 2>&1

:: --- Modificación de identificadores del sistema (PELIGROSO) ---
:: Nota: Estas modificaciones pueden romper Windows
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName /v ComputerName /t REG_SZ /d PizzaXYZ-%random% /f >nul 2>&1
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName /v ComputerName /t REG_SZ /d PizzaXYZ-%random% /f >nul 2>&1

REG ADD HKLM\SYSTEM\HardwareConfig /v LastConfig /t REG_SZ /d {eac%random%} /f >nul 2>&1
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001 /v HwProfileGuid /t REG_SZ /d {PizzaXYZ-%random%-%random%-%random%-%random%} /f >nul 2>&1
REG ADD HKLM\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001 /v GUID /t REG_SZ /d {PizzaXYZ-%random%-%random%-%random%-%random%} /f >nul 2>&1

REG ADD HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion /v BuildGUID /t REG_SZ /d PizzaXYZ-%random% /f >nul 2>&1
REG ADD HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion /v RegisteredOwner /t REG_SZ /d PizzaXYZ-%random% /f >nul 2>&1
REG ADD HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion /v RegisteredOrganization /t REG_SZ /d PizzaXYZ-%random% /f >nul 2>&1

REG ADD HKLM\SOFTWARE\Microsoft\Cryptography /v GUID /t REG_SZ /d PizzaXYZ-%random%-%random%-%random%-%random% /f >nul 2>&1
REG ADD HKLM\SOFTWARE\Microsoft\Cryptography /v MachineGuid /t REG_SZ /d PizzaXYZ-%random%-%random%-%random%-%random% /f >nul 2>&1

REG ADD HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion /v ProductId /t REG_SZ /d %random%-%random%-%random%-%random% /f >nul 2>&1
REG ADD HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion /v InstallDate /t REG_SZ /d %random% /f >nul 2>&1

REG ADD HKLM\SYSTEM\CurrentControlSet\Control\SystemInformation /v ComputerHardwareId /t REG_SZ /d {%random%-%random%-%random%-%random%} /f >nul 2>&1

:: --- Eliminar opciones de inicio del sistema ---
reg delete "HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control" /v SystemStartOptions /f >nul 2>&1

:: --- Limpieza adicional del registro ---
reg delete "HKEY_CURRENT_USER\Software\Classes\Installer\Dependencies" /v MSICache /f >nul 2>&1
reg delete "HKEY_CURRENT_USER\Software\Microsoft\Direct3D" /v WHQLClass /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\Hardware\Description\System\CentralProcessor\0" /v ProcessorNameString /f >nul 2>&1
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\HardwareConfig" /f >nul 2>&1

:: --- Configuración de Windows Update (modifica ID) ---
REG ADD HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate /v SusClientId /t REG_SZ /d {PizzaXYZ-%random%-%random%-%random%-%random%} /f >nul 2>&1

:: --- Limpieza de Xbox Game Bar/Overlay ---
:: (Solo eliminando claves de registro, no archivos)
reg delete "HKLM\SOFTWARE\Microsoft\RADAR\HeapLeakDetection\DiagnosedApplications\FortniteClient-Win64-Shipping.exe" /f >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\SecurityManager\CapAuthz\ApplicationsEx\Microsoft.XboxGameOverlay_1.41.24001.0_x64__8wekyb3d8bbwe" /f >nul 2>&1

:: --- Servicios de EasyAntiCheat ---
reg delete "HKLM\SOFTWARE\WOW6432Node\EasyAntiCheat" /f >nul 2>&1
reg delete "HKLM\SYSTEM\ControlSet001\Services\EasyAntiCheat" /f >nul 2>&1
reg delete "HKLM\SYSTEM\CurrentControlSet\Services\EasyAntiCheat" /f >nul 2>&1

echo.
echo ==============================================
echo OPERACIONES COMPLETADAS
echo ==============================================
echo - Procesos cerrados (si estaban ejecutándose)
echo - Registro de Epic Games limpiado
echo - Identificadores del sistema modificados
echo - Configuraciones de Windows Update alteradas
echo ==============================================
echo.
echo ADVERTENCIA: Este script ha realizado cambios profundos
echo en el sistema que podrían afectar la estabilidad.
echo.
pause
