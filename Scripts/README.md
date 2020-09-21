# Just a cheat sheet for useful stuff I've found.

# Add options for batch scripts. 
```
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

:exit
@exit
```
# Multiple choice powershell 

```
do { $myInput = (Read-Host 'Bla bla? (Y/N)').ToLower() } while ($myInput -notin @('y','n'))
if ($myInput -eq 'y') {
'branch for yes'
} else {
'branch for no'
}
```
# Creates a empty output for a command.
`> $null 2>&1 hide output with this`