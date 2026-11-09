This folder is a temporary solution for adding the functionality of a progressbar to the Get-task of Ant. A PR has been made to the Apache Ant repository, but has not yet been reviewed (https://github.com/apache/ant/pull/224).

The goal is to replace the current verbose behaviour of the Ant Get-task with a progressbar as to give more actually useful information.

progressbarget.jar is compiled against the Ant version in property `ant.version.` of build.xml (the version is stored as `Compiled-Against-Ant-Version` in the manifest of the jar). Target `progressbarget.jar` of build.xml rebuilds the jar when it was compiled against another Ant version. It downloads ant.jar and ant-launcher.jar of that Ant version from Maven Central and compiles ProgressBarGet.java for Java 17.

When Renovate updates Ant, its post-upgrade task (.github/workflows/generateScripts.sh) runs this target, so the rebuilt jar is part of the Renovate pull request. When you update Ant manually, run the target yourself and commit the new jar:

```
ant.bat init progressbarget.jar
```

(or `./ant.sh init progressbarget.jar` on Linux and Mac).

If you want to make any changes:

1. Make your changes in ProgressBarGet.java.
2. Rebuild the jar, forcing a rebuild because the Ant version did not change: ```ant.bat init progressbarget.jar -Dprogressbarget.jar.force=true```
3. You can commit and push your new .jar-file, but make sure it's located in frank-runner\extensions\progress-bar\progressbarget.jar.

This .jar-file gets automatically copied to the lib-folder of Ant when running start.bat/restart.bat/etc., which makes it accessible for use in the build.xml. The new jar is therefore used from the next run of these scripts on.
