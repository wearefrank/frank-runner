@echo off
if not exist "%~dp0download\" (
	mkdir "%~dp0download"
)
if not exist "%~dp0build\tmp\build\" (
	mkdir "%~dp0build\tmp\build"
)
if not exist "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip" (
	echo Download:
	echo https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u252-b09/OpenJDK8U-jdk_x64_windows_8u252b09.zip
	echo To:
	echo %~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip
	echo !!
	echo !! In case of errors you might want to do this manually and/or restart this script
	echo !!
	curl -o "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip.tmp" -L https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u252-b09/OpenJDK8U-jdk_x64_windows_8u252b09.zip
	if errorlevel 1 (
		goto error
	)
	move "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip.tmp" "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip"
)
if not exist "%~dp0build\openjdk-8u252-b09\" (
	tar xvf "%~dp0download\OpenJDK8U-jdk_x64_windows_8u252b09.zip" -C "%~dp0build\tmp\build"
	if errorlevel 1 (
		goto error
	)
	move "%~dp0build\tmp\build\openjdk-8u252-b09" "%~dp0build\openjdk-8u252-b09"
)
if not exist "%~dp0download\apache-ant-1.10.8-bin.zip" (
	echo Download:
	echo https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.8-bin.zip
	echo To:
	echo %~dp0download\apache-ant-1.10.8-bin.zip
	echo In case of errors you might want to do this manually
	curl -o "%~dp0download\apache-ant-1.10.8-bin.zip.tmp" -L https://archive.apache.org/dist/ant/binaries/apache-ant-1.10.8-bin.zip
	if errorlevel 1 (
		goto error
	)
	move "%~dp0download\apache-ant-1.10.8-bin.zip.tmp" "%~dp0download\apache-ant-1.10.8-bin.zip"
)
if not exist "%~dp0build\apache-ant-1.10.8\" (
	tar xvf "%~dp0download\apache-ant-1.10.8-bin.zip" -C "%~dp0build\tmp\build"
	if errorlevel 1 (
		goto error
	)
	move "%~dp0build\tmp\build\apache-ant-1.10.8" "%~dp0build\apache-ant-1.10.8"
)
set JAVA_HOME=%~dp0build\openjdk-8u252-b09
call "%~dp0build\apache-ant-1.10.8\bin\ant" -buildfile "%~dp0build.xml" %* run
if errorlevel 1 goto error
goto end
:error
set exiterrorlevel=%errorlevel%
set arg0=%0
if [%arg0:~2,1%]==[:] if not [%TERM_PROGRAM%] == [vscode] pause
exit /b %exiterrorlevel%
:end