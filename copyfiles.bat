@echo off

if not defined DRMINGW set DRMINGW=..\drmingw

set CONFIGURATION=%1
set PLATFORM=%2

set DEST=obj\%PLATFORM%\%CONFIGURATION%\

if %PLATFORM%==Win32 set DBGHELPERS=dbghelp_x86
if %PLATFORM%==x64   set DBGHELPERS=dbghelp_x64
copy /y %DBGHELPERS%\*.* %DEST%

if not exist %DBGHELPERS%\dbghelpw.dll copy /y "src\dbghelpw\wine\dlls\dbghelp\vs\bin\%PLATFORM%\%CONFIGURATION%\dbghelpw.dll" %DEST%
if %PLATFORM%==x64 if not exist %DBGHELPERS%\dbghelpw_wow64.dll copy /y "src\dbghelpw\wine\dlls\dbghelp\vs\bin\%PLATFORM%\%CONFIGURATION% - Wow64\dbghelpw.dll" %DEST%\dbghelpw_wow64.dll

if %PLATFORM%==Win32 set PLATFORM_BITS=32
if %PLATFORM%==x64   set PLATFORM_BITS=64

if not exist %DBGHELPERS%\dbghelpdr.dll copy %DRMINGW%\build\%PLATFORM_BITS%\bin\mgwhelp.dll %DEST%

copy /y src\crashback\bin\%PLATFORM%\%CONFIGURATION%\crashreport.exe %DEST%
