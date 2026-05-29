The goal is to replace the current verbose behaviour of the Ant Get-task with a progressbar as to give more actually useful information.

If you want to make any changes:

1. Make your changes in ProgressBarGet.java or CustomExec.java.
2. Check if build\apache-ant-1.10.17 exists, the classes needs ant.jar and ant-launcher.jar to compile.
3. Compile the class: ```javac -cp "build\apache-ant-1.10.17\lib\ant.jar;build\apache-ant-1.10.17\lib\ant-launcher.jar" -d extensions\progress-bar\build extensions\progress-bar\ProgressBarGet.java``` or ```javac -cp "build\apache-ant-1.10.15\lib\ant.jar;build\apache-ant-1.10.15\lib\ant-launcher.jar" -d extensions\progress-bar\build extensions\progress-bar\CustomExec.java```
4. Create the .jar-file: ```jar cf extensions\progress-bar\progressbarget.jar -C extensions\progress-bar\build .``` or ```jar cf extensions\progress-bar\customget.jar -C extensions\progress-bar\build .```
5. You can commit and push your new .jar-file, but make sure it's located in frank-runner\extensions\progress-bar\progressbarget.jar or frank-runner\extensions\progress-bar\customexec.jar.

The .jar-files get automatically copied to the lib-folder of Ant when running start.bat/restart.bat/etc., which makes it accessible for use in the build.xml.