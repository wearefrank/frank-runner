@echo off
if not exist "%~dp0build\java-se-8u40-ri\" (
	mkdir %~dp0build
	echo Please download https://download.java.net/openjdk/jdk8u40/ri/jdk_ri-8u40-b25-windows-i586-10_feb_2015.zip and unzip it in %~dp0build\
	pause
) else (
	if not exist "%~dp0build\apache-ant-1.10.7\" (
		echo Please download http://apache.redkiwi.nl//ant/binaries/apache-ant-1.10.7-bin.zip and unzip it in %~dp0build\
		pause
	) else (
		set JAVA_HOME=build\java-se-8u40-ri
		cd %~dp0
		build\apache-ant-1.10.7\bin\ant
		if errorlevel 1 (
			pause
		) else (
			build\sub.bat
		)
	)
)
		