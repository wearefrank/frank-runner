The ant-extension is a temporary solution for adding the functionality of a progressbar to the Get-task of Ant. A PR has been made to the Apache Ant repository, but has not yet been reviewed.

The goal is to replace the current verbose behaviour of the Ant Get-task with a progressbar as to give more actually useful information.

If you want to make any changes:

1. Make your changes in ProgressBarGet.java.
2. Compile the class: ```javac -cp "build\apache-ant-1.10.15\lib\ant.jar;build\apache-ant-1.10.15\lib\ant-launcher.jar" -d ant-extension\build ant-extension\ProgressBarGet.java```
3. Create the .jar-file: ```jar cf ant-extension\progressbarget.jar -C ant-extension\build .```

This .jar-file gets automatically copied to the lib-folder of Ant, which makes it accessible for use in the build.xml.