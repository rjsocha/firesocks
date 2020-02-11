@echo off
where powershell >NUL 2>NUL
if %ERRORLEVEL%  neq 0 goto nopowershell
rem save current powershell execution policy
for /f %%i in ('powershell Get-ExecutionPolicy -Scope CurrentUser') do set ExPolicy=%%i
rem change current execution policy to bypass 
powershell Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser -Force
rem execute powershell version of this script
powershell .\firesocks.ps1 %*
rem restore execution policy
powershell Set-ExecutionPolicy -ExecutionPolicy %ExPolicy% -Scope CurrentUser -Force
goto byebye
:nopowershell
echo powershell is required for this program to run.
:byebye