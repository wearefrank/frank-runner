# Frank!Runner

This project will help you run your Frank configurations with Tomcat.

Basically all you have to do is clone or download this project and run start.bat
by double clicking it. When Tomcat has started you can browse to the following
address:

```
http://localhost/
```

By default the frank2example1 project in the examples folder of the Frank!Runner
project will be used. To use your own project specify the project.dir. This can
be done in several ways. One way is to create a build.properties in the
frank-runner folder with the following content:

```
project.dir=frank2yourproject
```

Another way (when using the command line) is to add a -Dproject.dir argument
like:

```
projects\frank-runner> .\start.bat -Dproject.dir=frank2yourproject
```

Or to make it easy to switch between projects you can give every project it's
own small build.xml and run it for example from Eclipse or VSCode (see the
sections Eclipse and VSCode). An example build.xml for the frank2yourproject
could be:

```
<project default="restart.frank2yourproject">
	<target name="restart.frank2yourproject">
		<exec executable="../frank-runner/restart.bat" vmlauncher="false">
			<arg value="-Dproject.dir=frank2yourproject"/>
		</exec>
	</target>
</project>
```

The project.dir needs to be specified relative to the parent folder of the
frank-runner folder. In this case it is assumed that the frank2yourproject and
frank-runner folder share the same parent folder.

In case frank2yourproject contains a pom.xml it is assumed to be a Maven project
and the following default values are used:

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
   |--frank2yourproject
      |--classes
      |--configurations
         |--Config1
         |--Config2
         |--Conf...
      |--tests
      |--context.xml
   |--frank2otherproject
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
[Frank!Framework Manual](https://ibis4manual.readthedocs.io/).

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
switch between projects (see the beginning of this README).

Or open the Terminal view and execute the commands mentioned in the Command line
section below.


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
that need the Frank!Runner (see the beginning of this README).

Or use the terminal (e.g. right click on one of the Frank!Runner files and click
Open in Terminal) and execute the commands mentioned in the Command line
section below.

It is also possible to define a task (Terminal, Run Task...) and for example
add the following to .vscode/tasks.json:

```
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Restart",
            "type": "shell",
            "command": "../frank-runner/restart.bat '-Dproject.dir=frank2yourproject'",
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
projects> git clone https://github.com/ibissource/frank!framework
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

```
http://localhost/
```

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
path\to\frank-runner\start.bat -Dibis.version=7.2 -Dlog.dir=logs/7.2
```

This will create the instance, deploy on Tomcat, start Tomcat and return to the
script. To shutdown Tomcat, call stop:

```
path\to\frank-runner\stop.bat
```
