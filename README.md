# Frank!Runner

This project will help you run your Frank configurations with Tomcat.

Basically all you have to do is clone or download this project and run start.bat
by double clicking it. When Tomcat has started you can browse to the following
address:

http://localhost/


# Switching projects

By default the Frank2Example1 project in the examples folder of the Frank!Runner
project will be used. To use your own project specify the project.dir. This can
be done in several ways. One way is to create a build.properties in the
frank-runner folder with the following content:

```
project.dir=Frank2YourApplication
```

The project.dir needs to be specified relative to the parent folder of the
frank-runner folder. In this case it is assumed that the Frank2YourApplication and
frank-runner folder share the same parent folder. Hence no other path elements
like in the following example are necessary.

```
project.dir=../path/to/your/Frank2YourApplication
```

To use Frank2Example2 use:

```
project.dir=${basedir.basename}/examples/Frank2Example2
```

Another way to specify the project.dir (when using the command line) is to add
a -Dproject.dir argument like:

```
projects\frank-runner> .\start.bat -Dproject.dir=Frank2YourApplication
```

Or to make it easy to switch between projects you can give every project it's
own small build.xml and run it for example from Eclipse or VSCode (see the
sections [Eclipse](#eclipse) and [VSCode](#vscode)). An example build.xml for
the Frank2YourApplication could be:

```
<project default="restart.frank2yourapplication">
	<target name="restart.frank2yourapplication">
		<exec executable="../frank-runner/restart.bat" vmlauncher="false">
			<arg value="-Dproject.dir=Frank2YourApplication"/>
		</exec>
	</target>
</project>
```


# Project structure and customisation

In case Frank2YourApplication contains a pom.xml it is assumed to be a Maven
project and the following default values are used:

```
classes.dir=src/main/resources
configurations.dir=src/main/configurations
tests.dir=src/test/testtool
context.xml=src/main/webapp/META-INF/context.xml
```

Otherwise:

```
classes.dir=classes
configurations.dir=configurations
tests.dir=tests
context.xml=context.xml
```

Hence by default your folder structure will need to look like the following:

```
|--projects
   |--frank-runner
   |--Frank2YourApplication
      |--classes
      |--configurations
         |--Config1
         |--Config2
         |--Conf...
      |--tests
      |--context.xml
   |--Frank2YourOtherApplication
```

You can overwrite default values by creating a frank-runner.properties in the
project to run. In case you need to change the default value for projects.dir
(which is ..) you can create a build.properties in the frank-runner folder
(which can also be used to specify the project.dir as explained earlier).

Your project doesn't need to contain a context.xml in case you want to use H2.

When changing files in the classes folder you need to restart Tomcat. When
changing files in the configurations folder you need to reload the configuration
in the Frank!Framework console (or restart Tomcat).

More information on Frank configuration files and Frank property files and how
to use them can be found in the
[Frank!Manual](https://frank-manual.readthedocs.io/).


# Frank!Framework version

By default the Frank!Runner will check once every hour at startup whether a new
Frank!Framework version is available and download and use the latest
Frank!Framework version. This means you are running a Frank!Framework version
with the latest and greatest features but also a version that did not yet pass
all quality checks yet. Hence, you might run into a bug in the Frank!Framework.
Please report any Frank!Framework bugs at:

https://github.com/ibissource/iaf/issues

We appreciate your help but in case you would like to use a more reliable
version and/or like to disable the update mechanism add the following to either
a build.properties in the frank-runner folder or a frank-runner.properties in
the root folder of your project:

```
update.strategy=none
```

Or specify a specific Frank!Framework version like:

```
ff.version=7.4
```

Or:

```
ff.version=7.6-20200306.163142
```

Check the following url to see all available Frank!Framework versions:

https://nexus.ibissource.org/service/local/repo_groups/public/content/org/ibissource/ibis-adapterframework-core/maven-metadata.xml

Please note that very old versions might not run correctly with the
Frank!Runner.


# Other properties and software versions

At the top of the build.xml (in the init target) you will find a lot of
properties which you can override in either a build.properties in the
frank-runner folder or a frank-runner.properties in the root folder of your
project.

You could for example specify a different JDK, Ant or Tomcat version. E.g. for
Tomcat use:

```
tomcat.version=7.0.100
```

Please consider making a pull request in case you find a newer software version
to keep the Frank!Runner up to date with the latest software versions.

In some cases you might want to run on a different port and/or context. E.g. to
run on:

http://localhost:81/test

Use:

```
tomcat.connector.port=81
context.path=test
```

In case you have another Tomcat running on port 80 (possible using another
Frank!Runner instance) you probably also want to change the tomcat.server.port
which defaults to 8005 to prevent a conflict between the two Tomcat instances.
E.g. use:

```
tomcat.server.port=8105
```


# How to add custom jars and classes

In case you need to (for example) add your own pipe which is not available in the
Frank!Framework or you would like to customize an existing pipe in the
Frank!Framework you can add a java folder to the project with your custom .java
 file(s).

For a Maven project the default value for the java folder is:

```
java.dir=src/main/java
```
Otherwise:

```
java.dir=java
```

For custom jar files create the following folders:


```
lib.server.dir=lib/server
lib.webapp.dir=lib/webapp
```

All jars added to lib/server are copied to the Tomcat lib folder. All jars added
to lib/webapp are copied to the WEB-INF/lib containing the Frank!Framework jar
files and dependencies.


# Eclipse

Right click on build.xml, Run As, Ant Build. The second time you can use the run
button on the Toolbar. You can either run the build.xml in the Frank!Runner
project or a small build.xml in your own project depending on how you want to
switch between projects (see section [Switching projects](#switching-projects)
above).

Or open the Terminal view and execute the commands mentioned in the
[Command line](#command-line) section below.


# VSCode

Install plugin Ant Target Runner and configure it to use ant.bat or any other
ant installation by adding the following to settings.json:

```
"ant.executable": "C:\\path\\to\\frank!framework\\ant.bat",
```

You might need to restart VSCode for the Ant Target Runner plugin to detect the
build.xml in the project you have opened. In case you have opened frank-runner
as a folder/workspace you can use the Ant Target Runner plugin to run it's
build.xml. Below the file explorer open the Ant Target Runner, select the
restart target and push the Run Selected Ant Target button. Because the Ant
Target Runner will only be able to use the build.xml in the currently opened
folder/workspace it is recommended to create a small build.xml in the projects
that need the Frank!Runner (see section
[Switching projects](#switching-projects) above).

Or use the terminal (e.g. right click on one of the Frank!Runner files and click
Open in Terminal) and execute the commands mentioned in the
[Command line](#command-line) section below.

It is also possible to define a task (Terminal, Run Task...) and for example
add the following to .vscode/tasks.json:

```
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Restart",
            "type": "shell",
            "command": "../frank-runner/restart.bat '-Dproject.dir=Frank2YourApplication'",
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

This will make it possible to restart using ctrl-shift-B.


# Command line

For Frank!Runner command line usage execute the commands below either from the
Windows Command Prompt, Windows PowerShell, a terminal in Eclipse, VSCode or any
other terminal.

In case you did not already clone or download Frank!Runner and you have the git
command available (otherwise download it manually or use another Git program to
clone the project):

```
projects> git clone https://github.com/ibissource/frank-runner
```

Change directory to frank-runner:

```
projects> cd frank-runner
```

And on Windows run the following command:

```
projects\frank-runner> .\run.bat
```

When not using Windows run (not available yet):

```
projects\frank-runner> ./run.sh
```

You can now browse to the following address to find the Frank!Framework
console:

http://localhost/

You can stop Tomcat using the following combination of keys: 

```
ctrl-c
```

Instead of the run script (.bat or .sh) you can also use the start, stop and
restart scripts which will return after being executed (opening Tomcat in a
separate window):

```
projects\frank-runner> .\start.bat
```

```
projects\frank-runner> .\stop.bat
```

```
projects\frank-runner> .\restart.bat
```


# Scripting

You can call Frank!Runner from a script. Any parameter passed to Frank!Runner
is passed to Ant and Tomcat. For instance, to create an instance with a specific
Frank!Framework version (7.2 in the example), logging to a specific log
directory, the following call can be made:

```
path\to\frank-runner\start.bat -Dff.version=7.2 -Dlog.dir=logs/7.2
```

This will create the instance, deploy on Tomcat, start Tomcat and return to the
script. To shutdown Tomcat, call stop:

```
path\to\frank-runner\stop.bat
```
