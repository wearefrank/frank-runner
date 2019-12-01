@echo off
if not exist "%~dp0build\openjdk-8u232-b09\" (
	mkdir %~dp0build
	echo Please download https://github.com/AdoptOpenJDK/openjdk8-upstream-binaries/releases/download/jdk8u232-b09/OpenJDK8U-jdk_x64_windows_8u232b09.zip and unzip it in %~dp0build\
	pause
) else (
	if not exist "%~dp0build\apache-ant-1.10.7\" (
		echo Please download http://apache.redkiwi.nl//ant/binaries/apache-ant-1.10.7-bin.zip and unzip it in %~dp0build\
		pause
	) else (
		set JAVA_HOME=build\openjdk-8u232-b09
		cd %~dp0
		build\apache-ant-1.10.7\bin\ant
		if errorlevel 1 (
			pause
		) else (
			build\sub.bat
		)
	)
)
		