@echo off
:: BatchGotAdmin
:-------------------------------------
REM --> İzin kontrolü yapılıyor
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
REM --> Eget hata alınırsa yönetici değiliz demektir.
if '%errorlevel%' NEQ '0' (
echo Administrator izni isteniyor...
goto UACPrompt
) else ( goto gotAdmin )
:UACPrompt
echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
set params = %*:"=""
echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs"
"%temp%\getadmin.vbs"
del "%temp%\getadmin.vbs"
exit /B
:gotAdmin
pushd "%CD%"
CD /D "%~dp0"
@echo Servisisminiyazın Servisi Olusturuluyor.
SC CREATE "Çalıştırılacakservis" binpath= "C:\Dosyayolu\çalıştırmakistediğiniz.exe"
SC START Servisisminiz
SC config "buraya çalıştırmak istediğiniz servisi yazın (") silin " start= auto
SC failure "buraya çalıştırmak istediğiniz servisi yazın (") silin " reset=0 actions=restart/60000/restart/60000/restart/1000
sc failure "buraya çalıştırmak istediğiniz servisi yazın (") silin " command= ""C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" "C:\AT\MyPowerShellScript.ps1" "possibleArguments""
time /t 3
exit
