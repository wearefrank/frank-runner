@echo off
setlocal enabledelayedexpansion
if not exist "%~dp0download\" (
	mkdir "%~dp0download"
)
if not exist "%~dp0build\tmp\build\" (
	mkdir "%~dp0build\tmp\build"
)
set download.help=download https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u252-b09/OpenJDK8U-jdk_x64_windows_8u252b09.zip manually, move it to %~dp0download and restart this script
if not exist "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip" (
	echo In case of errors %download.help%
	curl -f -o "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip.tmp" -L https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u252-b09/OpenJDK8U-jdk_x64_windows_8u252b09.zip
	if !errorlevel! neq 0 (
		echo Please %download.help%
		goto error
	)
	move "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip.tmp" "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip"
)
if not exist "%~dp0build\openjdk-8u252-b09\" (
	tar xvf "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip" -C "%~dp0build\tmp\build"
	if !errorlevel! neq 0 (
		echo Please %download.help%
		goto error
	)
	move "%~dp0build\tmp\build\openjdk-8u252-b09" "%~dp0build\openjdk-8u252-b09"
)
set download.help=download https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip manually, move it to %~dp0download and restart this script
if not exist "%~dp0download\apache-maven-3.6.3-bin.zip" (
	echo In case of errors %download.help%
	curl -f -o "%~dp0download\apache-maven-3.6.3-bin.zip.tmp" -L https://archive.apache.org/dist/maven/maven-3/3.6.3/binaries/apache-maven-3.6.3-bin.zip
	if !errorlevel! neq 0 (
		echo Please %download.help%
		goto error
	)
	move "%~dp0download\apache-maven-3.6.3-bin.zip.tmp" "%~dp0download\apache-maven-3.6.3-bin.zip"
)
if not exist "%~dp0build\apache-maven-3.6.3\" (
	tar xvf "%~dp0download\apache-maven-3.6.3-bin.zip" -C "%~dp0build\tmp\build"
	if !errorlevel! neq 0 (
		echo Please %download.help%
		goto error
	)
	move "%~dp0build\tmp\build\apache-maven-3.6.3" "%~dp0build\apache-maven-3.6.3"
)
set JAVA_HOME=%~dp0build\openjdk-8u252-b09
call "%~dp0build\apache-maven-3.6.3\bin\mvn.cmd" %*
if %errorlevel% equ 0 goto end
:error
rem https://superuser.com/questions/527898/how-to-pause-only-if-executing-in-a-new-window
set arg0=%0
if [%arg0:~2,1%]==[:] if not [%TERM_PROGRAM%] == [vscode] pause
exit /b %errorlevel%
:end