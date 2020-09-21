# MRQ

===================================================================================================================
yes or no/two option script batch
:choice
set /P c=Would you like to apply this?[Y/N]?
if /I "%c%" EQU "Y" goto :yes
if /I "%c%" EQU "N" goto :no
goto :choice


:yes

<insert code/command here>

:no

<insert code/command here>
===================================================================================================================
multiple choice script batch

echo off
:begin
echo Select a task:
echo =============
echo -
echo 1) Option 1
echo 2) Option 2
echo 3) Option 3
echo 4) Option 4
echo -
set /p op=Type option:
if "%op%"=="1" goto op1
if "%op%"=="2" goto op2
if "%op%"=="3" goto op3
if "%op%"=="4" goto op4

echo Please Pick an option:
goto begin


:op1
echo you picked option 1
goto begin

:op2
echo you picked option 2
goto begin

:op3
echo you picked option 3
goto begin

:op4
echo you picked option 4
goto begin

:exit
@exit

=============================================================================================================
powershell y or no. add more if ($myinput eq- '<whatever>') for it to be come multiple single choice.

do { $myInput = (Read-Host 'Bla bla? (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
'branch for yes'
} else {
'branch for no'
}
==============================================================================================================
> $null 2>&1 hide output with this