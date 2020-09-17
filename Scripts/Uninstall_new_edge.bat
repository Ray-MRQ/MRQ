@echo off
goto check_Permissions

:check_Permissions
    echo Administrative permissions required. 
	echo -----------------------------------------
	echo Detecting permissions...
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed.
		echo -------------------------------------
    ) else (
        echo Failure: Current permissions inadequate.
		echo -------------------------------------
		echo Run as administrator and try again.
		pause
		exit
    )
rmdir /q /s "C:\Program Files (x86)\Microsoft\Edge"
rmdir /q /s "C:\Program Files (x86)\Microsoft\EdgeUpdate"
rmdir /q /s "C:\Program Files (x86)\Microsoft\Temp"
rem "This should now remove the new edge, you might need to delete from the Recyle bin as well"
pause