@echo off
chcp 65001 > nul
title Información de Hardware
color 0A

echo ==========================================
echo    INFORMACIÓN DE HARDWARE - PC SPECS
echo ==========================================
echo.
echo Recopilando información del sistema...
echo.

echo ==========================================
echo           INFORMACIÓN GENERAL
echo ==========================================
echo.
echo Nombre del equipo: %COMPUTERNAME%
echo Usuario actual: %USERNAME%
echo Fecha y hora: %DATE% %TIME%
echo.

echo ==========================================
echo           SISTEMA OPERATIVO
echo ==========================================
echo.
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"System Type"
echo.

echo ==========================================
echo              PROCESADOR (CPU)
echo ==========================================
echo.
powershell -Command "Get-CimInstance Win32_Processor | Select-Object Name,NumberOfCores,NumberOfLogicalProcessors,MaxClockSpeed | Format-List"
echo.

echo ==========================================
echo               MEMORIA RAM
echo ==========================================
echo.
echo Memoria total instalada:
powershell -Command "$mem = (Get-CimInstance Win32_ComputerSystem).TotalPhysicalMemory; Write-Output ([math]::Round($mem/1GB,2).ToString() + ' GB (' + [math]::Round($mem/1MB,0) + ' MB)')"
echo.
echo Información detallada de RAM:
powershell -Command "Get-CimInstance Win32_PhysicalMemory | ForEach-Object { $gb=[math]::Round($_.Capacity/1GB,2); $mb=[math]::Round($_.Capacity/1MB,0); Write-Output ('Capacidad: ' + $gb + ' GB (' + $mb + ' MB)'); Write-Output ('Velocidad: ' + $_.Speed + ' MHz'); Write-Output ('Tipo: ' + $_.MemoryType); Write-Output '' }"
echo.

echo ==========================================
echo           TARJETA GRÁFICA (GPU)
echo ==========================================
echo.
powershell -Command "Get-CimInstance Win32_VideoController | Select-Object Name,AdapterRAM,DriverVersion | Format-List"
echo.

echo ==========================================
echo         ALMACENAMIENTO (DISCOS)
echo ==========================================
echo.
echo Discos duros y SSD:
powershell -Command "Get-CimInstance Win32_DiskDrive | ForEach-Object { $gb=[math]::Round($_.Size/1GB,2); $mb=[math]::Round($_.Size/1MB,0); Write-Output ('Modelo: ' + $_.Model); Write-Output ('Tamaño: ' + $gb + ' GB (' + $mb + ' MB)'); Write-Output ('Interfaz: ' + $_.InterfaceType); Write-Output '' }"
echo.
echo Espacio libre en unidades:
powershell -Command "Get-CimInstance Win32_LogicalDisk | ForEach-Object { $sizeGB=[math]::Round($_.Size/1GB,2); $freeGB=[math]::Round($_.FreeSpace/1GB,2); Write-Output ('Unidad: ' + $_.DeviceID); Write-Output ('Tamaño: ' + $sizeGB + ' GB'); Write-Output ('Libre: ' + $freeGB + ' GB'); Write-Output ('Sistema de archivos: ' + $_.FileSystem); Write-Output '' }"
echo.

echo ==========================================
echo            PLACA BASE (MOTHERBOARD)
echo ==========================================
echo.
powershell -Command "Get-CimInstance Win32_BaseBoard | Select-Object Manufacturer,Product,Version | Format-List"
echo.

echo ==========================================
echo IMPORTANTE: Toma una captura de pantalla de esta información
echo ==========================================
echo.
echo        PRESIONA CUALQUIER TECLA PARA SALIR
echo ==========================================
pause > nul