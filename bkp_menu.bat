@echo off
echo "::: Backup/Resore saves for GreenHell ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::: Oxymoron ::: Mar 2023 :::"
set currDir=%~dp0
echo Current Dir: %currDir%

for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
set "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
rem set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
set "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%"
echo Timestamp: %fullstamp%

:menu
echo "::: Please select an option :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo 1 - Just backup
echo 2 - Backup to Mode-Level folder
echo 3 - Restore from folder
echo 9 - Exit
choice /n /c:123456789 /M "Choose an option: "
GOTO LABEL-%ERRORLEVEL%

:LABEL-1 BackupAll
    echo "::: Backup files to BKP dir :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    set backupFolder=bkp
	echo %backupFolder%
	
	set bkpDir=%backupFolder%\%fullstamp%
	echo %bkpDir%
	xcopy %currDir%\SPSlot*.sav* %currDir%\%bkpDir%\*.* /v
	
    PAUSE
goto menu
:LABEL-2 Backup
    echo "::: Backup files to Mode-Level dir :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
	set modeName=Survive
    set /p modeName="Enter mode name (press Enter for default [Survive])=> "
	echo Mode: %modeName%
	set diffName=Welcome
    set /p diffName="Enter level name (press Enter for default [Welcome])=> "
	echo Level: %diffName%	
	set bkpDir=%modeName%-%diffName%
	echo Dir to save: %bkpDir%
	if exist %bkpDir%\*.sav* (
		set timeDir=%bkpDir%\%fullstamp%
		echo ::: !!! ::: There are files in the folder [%bkpDir%]
		echo ::: !!! ::: Back up to timestamp dir: %timeDir%
		mkdir %timeDir%
		move %currDir%%bkpDir%\SPSlot*.sav* %currDir%%timeDir%
	)

	xcopy %currDir%SPSlot*.sav* %currDir%%bkpDir%\*.* /v
    PAUSE
goto menu
:LABEL-3 Restore
    echo "::: Restore all files from backup :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
	set modeName=Survive
    set /p modeName="Enter mode name (press Enter for default [Survive])=> "
	echo Mode: %modeName%
	set diffName=Welcome
    set /p diffName="Enter level name (press Enter for default [Welcome])=> "
	echo Level: %diffName%
	set bkpDir=%modeName%-%diffName%
	echo Restore from dir: %bkpDir%
	echo You are going to override current files in: %currDir%
	rem set /p prompt=Are You Sure?[y/n]: 
	rem if not %prompt%==y goto menu

	xcopy %currDir%%bkpDir%\SPSlot*.sav* %currDir%*.* /v
	
	del *.nfo
	echo "Restore time: %fullstamp%">%currDir%%bkpDir%.nfo

    PAUSE
goto menu
:LABEL-9 EX
    echo ":::::::::::::::::::::::: Green Hell Forever!!! Happy Gaming! :-) :::::::::::::::::::::::::::::::::::::::"
