# Frank!Runner

This project will help you run the
[Frank!Framework](https://frankframework.org/) and the
[Frank!Flow](https://github.com/ibissource/frank-flow#frankflow) to develop
your [Frank! configurations](https://frank-manual.readthedocs.io/en/latest/).

Add a [small build.xml](#small-buildxml-for-every-project) to your project and
run it using a [small restart.bat](#small-restartbat-for-every-project) /
[.sh](#small-restartsh-for-every-project), [VSCode](#vscode) or
[Eclipse](#eclipse).


# Contents

- [Installation](#installation)
- [Examples](#examples)
- [Specials](#specials)
- [Project structure and customisation](#project-structure-and-customisation)
- [Project per config](#project-per-config)
- [Module per config](#module-per-config)
- [Debug property](#debug-property)
- [Frank!Framework version](#frankframework-version)
- [Other properties and software versions](#other-properties-and-software-versions)
- [Code completion with FrankConfig.xsd](#code-completion-with-frankconfigxsd)
- [How to add custom jars and classes](#how-to-add-custom-jars-and-classes)
- [Web development](#web-development)
- [Root CA certificates](#root-ca-certificates)
- [Eclipse](#eclipse)
- [VSCode](#vscode)
- [Command line](#command-line)
- [Scripting](#scripting)


# Installation

## Clone or download the Frank!Runner

Clone or download this Frank!Runner project into the projects folder that
contains your Frank project(s) (make the frank-runner folder a sibling of your
project folder).

You can now run Frank!Runner build.xml files in projects that already have them
(like the example projects in [frank-runner/examples](#examples)).

Use the [restart.bat](#small-restartbat-for-every-project) or
[restart.sh](#small-restartsh-for-every-project) in these projects or see the
sections [Eclipse](#eclipse) and [VSCode](#vscode) on how to use Eclipse and
VSCode to run a build.xml. When you're behind a Secure Web Gateway like Zscaler
and/or need to download files from your organization's internal repository
(e.g. Artifactory), see section [Root CA certificates](#root-ca-certificates).

When Tomcat has started by running a Frank!Runner
[build.xml](#small-buildxml-for-every-project) you can browse to the following
addresses:

http://localhost

http://localhost/frank-flow

The secure port is also enabled:

https://localhost

https://localhost/frank-flow

## Small build.xml for every project

In case your project doesn't contain a build.xml yet you can add it to the root
folder of your project with the following content:

```
<project default="restart">
	<target name="restart">
		<basename property="project.dir" file="${basedir}"/>
		<condition property="exe" value="../frank-runner/restart.bat" else="/bin/bash"><os family="windows"/></condition>
		<condition property="arg" value="../frank-runner/restart.sh" else=""><os family="unix"/></condition>
		<exec executable="${exe}" vmlauncher="false" failonerror="true">
			<arg value="${arg}"/>
			<arg value="-Dproject.dir=${project.dir}"/>
		</exec>
	</target>
</project>
```

For Mac we need to use /bin/bash with restart.sh as an argument to work around:
Cannot run program "restart.sh" (in directory ".../FrankRunner/frank-runner"): error=2, No such file or directory

To make the items in the Last Tasks list of the Task Explorer unique you can
rename the target name restart in build.xml to something unique for your project
(e.g. restart-frank2yourproject) (make the value of the default attribute of the
project element the same).

## Small restart.bat for every project

Create a restart.bat with the following content in the root folder of your
project which you can run from Windows Explorer:

```
call ..\frank-runner\ant.bat
if %errorlevel% equ 0 goto end
rem https://superuser.com/questions/527898/how-to-pause-only-if-executing-in-a-new-window
set arg0=%0
if [%arg0:~2,1%]==[:] if not [%TERM_PROGRAM%] == [vscode] pause
:end
```

## Small restart.sh for every project

Create a restart.sh with the following content in the root folder of your
project for Linux and Mac:

```
#!/bin/bash
../../ant.sh
```

## Customizations of build.xml

There are other ways possible to run the Frank!Runner scripts but to make it
easy for all project members and to have good integration with
[Eclipse](#eclipse) and [VSCode](#vscode) the preferred way is to use a
[build.xml](#small-buildxml-for-every-project) and optionally a
[restart.bat](#small-restartbat-for-every-project) and
[restart.sh](#small-restartsh-for-every-project). Because the
[build.xml](#small-buildxml-for-every-project) can be customized and to keep
all customizations in one place
[restart.bat](#small-restartbat-for-every-project) calls
[ant.bat](ant.bat) to run the [build.xml](#small-buildxml-for-every-project)
(instead of calling [restart.bat](restart.bat)).


# Examples

The Frank!Runner is shipped with the following examples


## Frank2Example1

Most basic Hello World example showing two configurations with unit tests. The Frank!Manual
is being updated to reference this example properly.

## Frank2Example2

Some more Hello Wold adapters. These use the normal classpath. This example is not referenced by the Frank!Manual.

## Frank2Example3

Example usage of message log, error store, message store sender and message
store listener. Description attributes have been added to the adapters which
can be read from the console. This will explain how to test and use the
adapters to be able to understand how the to e.g. resend messages.

This example is referenced by the Frank!Manual at the following location:

https://frank-manual.readthedocs.io/en/latest/operator/managingProcessedMessages.html#

## Frank2Example4

Example usage of Maven, custom views and a very small web application. See the
custom menu items at top of the Frank!Console menu. Better example Frank!
configuration or web application files are appreciated. Please create a pull
request, an issue or send an email with your improvements.

## Frank2Example5

Demonstrates [module per config](#module-per-config).


# Specials

To run the webapp, example and test modules of 
https://github.com/ibissource/iaf you can use the build.xml files in the
specials folder. As with other projects the iaf folder needs to be a sibling
folder of the frank-runner folder. See also the build-example.properties files
in these folders that describe several properties that can be set to speed up
and customize the build.


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

Hence by default your folder structure will need to look like the following (for
non-maven projects):

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
      |--build.xml
      |--restart.bat
   |--Frank2YourOtherApplication
      |--...
```

You can overwrite default values by creating a frank-runner.properties in the
project to run. In case you need to change the default value for projects.dir
(which is ..) you can create a build.properties in the frank-runner folder
(which can also be used to specify the project.dir as explained earlier).

Your project doesn't need to contain a context.xml in case you want to use an
H2 database.

When changing files in the classes folder you need to restart Tomcat. When
changing files in the configurations folder you need to reload the configuration
in the Frank!Framework console (or restart Tomcat).

More information on Frank configuration files and Frank property files and how
to use them can be found in the
[Frank!Manual](https://frank-manual.readthedocs.io/).


# Project per config

In case your application comprises several Frank!Configurations and you would
like to have a project per configuration (e.g. to give each configuration it's
own CI/CD pipeline) the following setup is possible and is automatically
detected by the Frank!Runner based on the presence of the war/pom.xml:

```
|--projects
   |--frank-runner
   |--frank2application
      |--ear
      |  |--src
      |  |  |--...
      |  |--pom.xml
      |--war
      |  |--src
      |  |  |--main
      |  |  |  |--configurations
      |  |  |  |--webapp
      |  |  |  |--...
      |  |  |--test
      |  |     |--testtool
      |  |--pom.xml
      |--build.xml
      |--pom.xml
      |--restart.bat
   |--frank2application_config1
      |--src
      |  |  |--main
      |  |  |  |--configuration
      |  |  |     |--Config1
      |  |  |--test
      |  |     |--testtool
      |--build.xml
      |--pom.xml
      |--restart.bat
   |--frank2application_config2
      |--...
   |--frank2application_config3
      |--...
```

The build.xml files in the config projects need to have to following content
(see section [Installation](#installation) for the content of the build.xml
that should be added to the main project) (you can rename target restart to
restart-&lt;projectname&gt; to have better overview on the Last Tasks list of
the Task Explorer):

```
<project default="restart">
	<target name="restart">
		<basename property="project.dir" file="${basedir}"/>
		<split projectdir="${project.dir}"/>
		<condition property="exe" value="../frank-runner/restart.bat" else="/bin/bash"><os family="windows"/></condition>
		<condition property="arg" value="../frank-runner/restart.sh" else=""><os family="unix"/></condition>
		<exec executable="${exe}" vmlauncher="false" failonerror="true">
			<arg value="${arg}"/>
			<arg value="-Dmain.project=${main.project}"/>
			<arg value="-Dsub.project=${sub.project}"/>
		</exec>
	</target>
	<scriptdef language="javascript" name="split">
		<attribute name="projectdir"/> 
		var projectDir = attributes.get("projectdir");
		var i = projectDir.indexOf('_');
		project.setProperty("main.project", projectDir.substring(0, i));
		project.setProperty("sub.project", projectDir.substring(i + 1));
	</scriptdef>
</project>
```

This way every (configuration) project can be started and tested by it's own.


# Module per config

In case your application comprises several Frank!Configurations and you would
like to have a Maven module per configuration the following setup is possible
and is automatically detected by the Frank!Runner based on the presence of the
war/pom.xml (see Frank2Example5 also):

```
|--projects
   |--frank-runner
   |--frank2application
      |--configurations
      |  |--Example1
      |  |  |--src
      |  |  |  |--main
      |  |  |  |--resources
      |  |  |  |  |--Example1
      |  |  |  |     |--Configuration.xml
      |  |  |  |     |--...
      |  |  |  |--test
      |  |  |     |--testtool
      |  |  |        |-...
      |  |  |--build.xml
      |  |  |--restart.bat
      |  |  |--restart.sh
      |  |  |--...
      |  |--Example2
      |  |  |--...
      |  |--...
      |--ear
      |  |--src
      |  |  |--...
      |  |--pom.xml
      |--war
      |  |--src
      |  |  |--main
      |  |  |  |--configurations
      |  |  |  |  |--...
      |  |  |  |--resources
      |  |  |  |  |--Configuration.xml
      |  |  |  |  |--...
      |  |  |  |--webapp
      |  |  |  |--...
      |  |  |--test
      |  |     |--testtool
      |  |        |-...
      |  |--pom.xml
      |--build.xml
      |--pom.xml
      |--restart.bat
      |--restart.sh
```

The build.xml files for the modules need to have to following content (see
section [Installation](#installation) for the content of the build.xml that
should be added to the root of the project) (you can rename target restart to
restart-&lt;projectname&gt;-&lt;modulename&gt; to have better overview on the
Last Tasks list of the Task Explorer):

```
<project default="restart">
	<target name="restart">
		<basename property="project.dir" file="${basedir}"/>
		<basename property="module.dir" file="${basedir}"/>
		<condition property="exe" value="../../restart.bat" else="/bin/bash"><os family="windows"/></condition>
		<condition property="arg" value="../../restart.sh" else=""><os family="unix"/></condition>
		<exec executable="${exe}" vmlauncher="false" failonerror="true">
			<arg value="${arg}"/>
			<arg value="-Dprojects.dir=${basedir}/.."/>
			<arg value="-Dproject.dir=${project.dir}"/>
			<arg value="-Dmodule.dir=&quot;${module.dir}&quot;"/>
		</exec>
	</target>
</project>
```

This way every module can be started and tested on it's own running only the
configuration of this specific module. It is also possible to start other
configurations by adding the following:

```
	<arg value="-Dconfigurations.names=&quot;${module.name},OtherModuleName,OtherConfigurationName&quot;"/>
```

When a Configuration.xml is detected in war/src/main/resources it is
automatically added to the list (this is also the case when
configurations.names is not specified and defaults to only the configuration of
one module).

See Frank2Example5 for example pom.xml files for the modules and the parent.



# Debug property

Add the following to either a build.properties in the frank-runner folder or a
frank-runner.properties in the root folder of your project to make the
Frank!Runner display the most important properties just above the Frank!Runner
ASCII art:

```
debug=true
```


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

https://nexus.frankframework.org/repository/public/org/ibissource/ibis-adapterframework-webapp/maven-metadata.xml

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

http://localhost:8080/test

https://localhost:8443/test

Use:

```
tomcat.port=8080
tomcat.secure.port=8443
context.path=test
```

In case you have another Tomcat running on port 80 (possible using another
Frank!Runner instance) you probably also want to change the tomcat.server.port
which defaults to 8005 to prevent a conflict between the two Tomcat instances.
E.g. use:

```
tomcat.server.port=8105
```

# Code completion with FrankConfig.xsd

When Frank!Runner starts it will copy the FrankConfig.xsd from the
Frank!Framework webapp to your configurations folder so you can refer to it
in your configuration files like:

```
<Configuration
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:noNamespaceSchemaLocation="../FrankConfig.xsd"
	>
	<Adapter name="...">
      ...
	</Adapter>
</Configuration>
```

For configuration files that are included with an entity reference in the main
Configuration.xml you can use the following in case your configuration file
contains only one adapter:

```
<Adapter
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:noNamespaceSchemaLocation="../FrankConfig.xsd"
	name="..."
	>
	<Receiver>
		...
	</Receiver>
	<Pipeline name="...">
      ...
	</Pipeline>
</Adapter>
```

When you need to add more than one adapter and/or other elements (like a
Scheduler) you can use:

```
<Module
	xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	xsi:noNamespaceSchemaLocation="../FrankConfig.xsd"
	>
	<Adapter name="...">
      ...
	</Adapter>
	<Adapter name="...">
      ...
	</Adapter>
	<Scheduler>
		...
	</Scheduler>
</Module>
```

This will enable code completion in your IDE. Depending on the IDE you are
using you might need to configure your IDE. For Eclipse, no configuration is needed.
For VSCode, you need a plugin that is shown in [VSCode](#vscode).

The Frank!Runner will also add FrankConfig.xsd to .gitignore (when not already
present) to exclude the FrankConfig.xsd from git.

In case of a module per config or project per config setup the FrankConfig.xsd
will be copied to all modules / projects.

The Frank!Runner will update the FrankConfig.xsd every time the Frank!Framework
version is changed. In case you manually delete the FrankConfig.xsd from one of
the modules / projects it will only be recreated when the Frank!Framework
version is changed or when maven=true or when the FrankConfig.xsd is missing in
configurations.dir too.


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


# Web development

In case you want to develop and package a web application with your Frank! it
is recommended to setup your project as a Maven project as it will allow you to
edit the web application files in src/main/webapp and see the changes in your
browser without the need to restart your Frank!. A small example can be found
in [Frank2Example4](#frank2example4).


# Root CA certificates

You may need to add your organistion's Root CA for Ant and Maven to be able to
download files from behind a Secure Web Gateway like Zscaler and/or to download
files from your organization's internal repository (e.g. Artifactory). To do so
simply create a folder cacerts in the frank-runner folder and (re)start a
Frank!Runner build.xml. Frank!Runner will detect added and removed files from
the cacerts folder and reinstall all files in cacerts in the downloaded and
unzipped JDK used by the Frank!Runner. Also when the Frank!Runner's JDK version
is changed and a new JDK is downloaded Frank!Runner will install the Root CA's
in the cacerts folder in the newly downloaded and unzipped JDK.


# Eclipse

Choose one of the methods described in the sections below to run the build.xml
and/or restart.bat in your project. See section [Installation](#installation)
for more information on the build.xml and restart.bat and how to add them to
your project in case they don't exist yet.

## Ant

Right click on build.xml, Run As, Ant Build. The second time you can use the run
button on the Toolbar.

## Terminal

Open the terminal view, cd to your project and execute restart.bat.

## Eclipse installation

When property eclipse=true (false by default) the Frank!Runner will download
and install Eclipse with Lombok and add the certficates found in the cacerts
folder to the Eclipse JRE of this intallation.

You can start Eclipse by running eclipse(.exe) from the Eclipse folder which
can be found in the build folder of the Frank!Runner. Optionally create a
shortcurt for this executable which you can move to another location.

When using this Eclipse intallation to contribute to the Frank!Framework the
steps mentioned in

https://github.com/ibissource/iaf/blob/master/CONTRIBUTING.md#developing-with-eclipse

to install Eclipse with Lombok can be skipped. You can also skip setting up a
Tomcat server in Eclipse when you use [Specials](#specials) to start and stop
Tomcat. For the mentioned Java 8 requirement you have to manually go to Window,
Preferences, Java, Installed JREs and add the JDK 8 folder which can be found
in the build folder of the Frank!Runner. Check the checkbox for this JDK in the
overview of installed JREs.


# VSCode

To have syntax checking, autocomplete and tooltips from `FrankConfig.xsd` while
programming Frank configurations, install the plugin "XML Language Support by
Red Hat".

Choose one of the methods described in the sections below to run the build.xml
and/or restart.bat in your project. See section [Installation](#installation)
for more information on the build.xml and restart.bat and how to add them to
your project in case they don't exist yet.

## Task Explorer

Install plugin Task Explorer and configure it to use ant.bat or any other
Ant installation by filling "Path To Ant" in the Extension Settings of Task
Explorer with:

C:/path/to/frank-runner/ant.bat

Backslashes will also work except when your VSCode is configured to use a bash
shell.

Disable the "Enable Ansicon For Ant" option. Now you can use Task Explorer to
either run the build.xml or the restart.bat in your project.

Below the file explorer open the Task Explorer, select restart below ant or
restart.bat below batch and click the Run button.

## Task Explorer with Ansicon

It is also possible to install Ansicon and keep Ansicon enabled in the Task
Explorer plugin but your system might think it is malwar:

https://github.com/adoxa/ansicon/issues/30

You can download Ansion at:

https://github.com/adoxa/ansicon/releases

Fill "Path To Ansicon" in the Extension Settings of Task Explorer with the path
to Ansicon (and keep the "Enable Ansicon For Ant" option enabled) in case you
would like to use Ansicon.

## Ant Target Runner

Install plugin Ant Target Runner and configure it to use ant.bat or any other
ant installation by adding the following to settings.json:

```
"ant.executable": "C:\\path\\to\\frank-runner\\ant.bat",
```

You might need to restart VSCode for the Ant Target Runner plugin to detect the
build.xml in the project you have opened. Below the file explorer open the Ant
Target Runner, select the restart target and push the Run Selected Ant Target
button. Please note that the Ant Target Runner will only be able to use the
build.xml in the root of the currently opened folder/workspace.

## Terminal

Right click restart.bat in your project, click Open in Terminal and execute:

```
projects\your-project> .\restart.bat
```

## Task

In the root of the opened folder create a new folder called .vscode and within
the new .vscode folder create a tasks.json with the following content:

```
{
    "version": "2.0.0",
    "tasks": [
        {
            "label": "Restart",
            "type": "shell",
            "command": "./restart.bat",
            "group": {
                "kind": "build",
                "isDefault": true
            }
        }
    ]
}
```

This will make it possible to restart using ctrl-shift-B (or go to Terminal,
Run Task...).


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

On Windows run the following command:

```
projects\frank-runner> .\run.bat
```

And on Linux or Mac run:

```
projects\frank-runner> ./run.sh
```

You can now browse to the following address to find the Frank!Framework
console:

http://localhost

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

In case you want to use the Java, Ant and Maven installations downloaded by the
Frank!Runner on a command line for other projects too, double clicking cmd.bat
(on Windows) to start a new command line window with a PATH that contains the
Java, Ant and Maven installation. In case you already have a command line
window open on Windows run:

```
path\to\frank-runner\env.bat
```

And on Linux or Mac run:

```
source path/to/frank-runner/env.sh
```

After this you should be able to run java, ant and mvn in this window. Please
note that in case you use a Root CA certficate or Maven you have to run another
Frank!Runner script at least once to install the Root CA certficate in the JDK
folder and to download Maven.


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
