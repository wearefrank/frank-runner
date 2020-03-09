@echo off
if not exist "%~dp0download\" (
	mkdir "%~dp0download"
)
if not exist "%~dp0build\tmp\build\" (
	mkdir "%~dp0build\tmp\build"
)
if not exist "%~dp0download\OpenJDK8U-jdk_x64_windows_8.zip" (
	curl -o "%~dp0download\OpenJDK8U-jdk_x64_windows_8.zip.tmp" -L https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_windows_8u232b09.zip
	if errorlevel 1 (
		goto error
	)
	move "%~dp0download\OpenJDK8U-jdk_x64_windows_8.zip.tmp" "%~dp0download\OpenJDK8U-jdk_x64_windows_8.zip"
)
if not exist "%~dp0build\openjdk-8u232-b09\" (
	tar xvf "%~dp0download\OpenJDK8U-jdk_x64_windows_8.zip" -C "%~dp0build\tmp\build"
	if errorlevel 1 (
		goto error
	)
	move "%~dp0build\tmp\build\openjdk-8u232-b09" "%~dp0build\openjdk-8u232-b09"
)
if not exist "%~dp0download\apache-ant-1.10.7-bin.zip" (
	curl -o "%~dp0download\apache-ant-1.10.7-bin.zip.tmp" -L http://apache.redkiwi.nl//ant/binaries/apache-ant-1.10.7-bin.zip
	if errorlevel 1 (
		goto error
	)
	move "%~dp0download\apache-ant-1.10.7-bin.zip.tmp" "%~dp0download\apache-ant-1.10.7-bin.zip"
)
if not exist "%~dp0build\apache-ant-1.10.7\" (
	tar xvf "%~dp0download\apache-ant-1.10.7-bin.zip" -C "%~dp0build\tmp\build"
	if errorlevel 1 (
		goto error
	)
	move "%~dp0build\tmp\build\apache-ant-1.10.7" "%~dp0build\apache-ant-1.10.7"
)
set JAVA_HOME=%~dp0build\openjdk-8u232-b09
call "%~dp0build\apache-ant-1.10.7\bin\ant" -buildfile "%~dp0build.xml" %* build
if errorlevel 1 goto error
call "%~dp0build\run.bat" %*
if errorlevel 1 goto error
goto end
:error
pause
:end