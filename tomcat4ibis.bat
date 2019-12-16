@echo off
if not exist "%~dp0download\" (
	mkdir %~dp0download
)
if not exist "%~dp0build\" (
	mkdir %~dp0build
)
if not exist "%~dp0build\openjdk-8u232-b09\" (
	curl -o %~dp0download\OpenJDK8U-jdk_x64_windows_8.zip -L https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_windows_8u232b09.zip
	tar xvf %~dp0download\OpenJDK8U-jdk_x64_windows_8.zip -C %~dp0build
)
if not exist "%~dp0build\apache-ant-1.10.7\" (
	curl -o %~dp0download\apache-ant-1.10.7-bin.zip -L http://apache.redkiwi.nl//ant/binaries/apache-ant-1.10.7-bin.zip
	tar xvf %~dp0download\apache-ant-1.10.7-bin.zip -C %~dp0build
)
set JAVA_HOME=%~dp0build\openjdk-8u232-b09
call %~dp0build\apache-ant-1.10.7\bin\ant -buildfile %~dp0build.xml %*
if errorlevel 1 (
	pause
) else (
	call %~dp0build\sub.bat %*
)
		