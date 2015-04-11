@echo off

set GITSH="C:\Program Files (x86)\Git\bin\sh.exe"
set CFG_CONVERT=".\CfgConvert.exe"
set makepbo="C:\Program Files (x86)\Mikero\DePboTools\bin\makepbo.exe"

set STASH_REPO="http://dev.taskforce47.de/stash/scm/aiii/task-force-47-patrol-ops-altis.git"
set MISSIONFOLDER="tf47-patrolops.Altis"
set FINAL_PBO="%MISSIONFOLDER%.pbo"

echo ###################################
echo Starting GIT CLONE
echo ###################################
%GITSH% --login cloneAndParse.sh "%STASH_REPO%" "%MISSIONFOLDER%"
echo GIT CLONE finished

echo ######################################
echo let's build our final pbo with Mikero
echo ######################################
%makepbo% -AJBUPW -Z=default "%MISSIONFOLDER%"
pause