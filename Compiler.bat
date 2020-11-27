rem Remove rem from row 2 to update repo before compiling
rem git pull origin --verbose

IF NOT EXIST Compiled (
mkdir Compiled
) 
"%~dp0lua\lua52.exe" "%~dp0Setup\MDS_Framework_Create.lua" "%~dp0MDS_Framework" "%~dp0Setup" "%~dp0Compiled"

xcopy /s "%~dp0Compiled\MDS_Framework.lua" "E:\Projects\eclipse-workspace-lua\DCS_Missions\MDS_Framework"
pause