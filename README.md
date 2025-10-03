# Frank!Runner

This project will help you run the
[Frank!Framework](https://frankframework.org/) and the
[Frank!Flow](https://github.com/frankframework/frank-flow#frankflow) to develop
your [Frank!Configurations](https://frank-manual.readthedocs.io/en/latest/).

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
- [Module per config flattened (aka monorepo)](#module-per-config-flattened-aka-monorepo)
- [Debug property](#debug-property)
- [Frank!Framework version](#frankframework-version)
- [Other properties and software versions](#other-properties-and-software-versions)
- [Testing with DTAP stage different from LOC](#testing-with-dtap-stage-different-from-loc)
- [Code completion with FrankConfig.xsd](#code-completion-with-frankconfigxsd)
- [How to add custom jars and classes](#how-to-add-custom-jars-and-classes)
- [Web development](#web-development)
- [Root CA certificates](#root-ca-certificates)
- [Eclipse](#eclipse)
- [VSCode](#vscode)
- [Command line](#command-line)
- [Scripting](#scripting)
- [Troubleshooting](#troubleshooting)

# Installation

## Clone the Frank!Runner

Clone this Frank!Runner project into the projects folder that contains your
Frank project(s) (make the frank-runner folder a sibling of your project
folder).

```
git clone https://github.com/wearefrank/frank-runner.git
```

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

## Download the Frank!Runner

It is also possible to download this Frank!Runner project as a ZIP from GitHub
and unzip it. This might be easier for evaluation purposes but be aware that:

- On Mac an Linux use chmod +x *.sh to be able to run the .sh files
- Rename frank-runner-master to frank-runner for Frank project to find the
  Frank!Runner (not needed to run the examples frank-runner/examples)
- You need to download again to get a newer Frank!Runner version (with git only
  a git pull is needed update your Frank!Runner to the latest version)

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
../frank-runner/ant.sh
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
adapters to be able to understand how to e.g. resend messages.

This example is referenced by the Frank!Manual at the following location:

https://frank-manual.readthedocs.io/en/latest/operator/managingProcessedMessages.html#

## Frank2Example4

Example usage of Maven, custom views, a very small web application and the Frank!Flow. See the
custom menu items at top of the Frank!Console menu. Better example Frank!
configuration or web application files are appreciated. Please create a pull
request, an issue or send an email with your improvements.

## Frank2Example5

Demonstrates [module per config](#module-per-config).


# Specials

The main purpose of the Frank!Runner is to run released code of the
Frank!Framework. When you are doing development work on
Ladybug or the Frank!Framework, you may want to build the Frank!Framework
locally. You can use the `specials` folder and its children to run your local
build of the Frank!Framework source code, maybe including some changes of that
source code.

Here are short descriptions of the options provided in the `specials` folder:
* `specials/ladybug`: Builds a ladybug checkout as well. May be combined with
  F!F (property ``test.with.iaf=true`` in ``build.properties``) or with
  a simple test webapp https://github.com/wearefrank/ladybug-test-webapp
  (property ``test.with.iaf=false`` in ``build.properties``).
* `specials/iaf-webapp`: Runs locally-built basic F!F, to be combined with
  your own configuration.
* `specials/iaf-test`: Run the Larva tests of the Frank!Framework.
* `specials/iaf-example`: Runs the example Frank application included in
  the F!F source code.
* `specials/test-startup-times`
* `ladybug-frontend`: Runs Maven build of ladybug-frontend but does not launch
  anything.

In each mentioned subfolder, there is a `restart.bat` and a `restart.sh`
to build the Frank!Framework, ladybug or ladybug-test-webapp and to
run the Frank!Framework.
In each case, you can write
your own `build.properties` next to the `restart.bat|sh` scripts to customize
the build process. Please only use
properties that appear in the `build-example.properties` files supplied.
Properties that work for ordinary use of the Frank!Runner may not work with a
`specials/...` case. The Frank!Framework sources should be in a folder named
`frankframework` that is a sibling of the Frank!Runner checkout.

**specials/iaf-webapp:** Use this folder to run your own Frank configuration
with a modified locally-built version of the Frank!Framework. Put your
configuration in `examples/Frank2Example1/configurations` or use property
``configurations.dir`` in ``build.properties`` to configure a different
location. If you need
class-level properties or configurations, put it in your `frankframework`
checkout and not in your Frank!Runner checkout. Use folder
`frankframework/webapp/src/main/resources`.

There is an additional consideration when running `specials/ladybug` with
`test.with.iaf=true`. Doing this requires that the `pom.xml` files in the
frankframework and ladybug checkouts are aligned. The ladybug version
referenced in `frankframework/ladybug/pom.xml` must be the version of the
ladybug checkout. If you want to build with the latest ladybug-frontend code,
you also have to do the Maven build of ladybug-frontend, and the ladybug
frontend version referenced in `ladybug/pom.xml` must match the version
defined in `ladybug-frontend/pom.xml`.

In `frank-runner/specials/util/syncPomVersions`, there is an ANT script to
adjust the mentioned `pom.xml` files to be aligned. To use it, change
directory to `frank-runner/specials/util/syncPomVersions` and execute the
`run.sh` or `run.bat` script.

# Project structure and customisation

In case Frank2YourApplication contains a pom.xml it is assumed to be a Maven
project and the following default values are used:

```
classes.dir=src/main/resources
configurations.dir=src/main/configurations
tests.dir=src/test/testtool
context.xml=src/main/webapp/META-INF/context.xml (read about resources.yml below)
```

Otherwise:

```
classes.dir=classes
configurations.dir=configurations
tests.dir=tests
context.xml=context.xml (read about resources.yml below)
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

If your project has a `pom.xml`, you can choose whether the Frank!Runner
should build your project with Maven (by default not, building is then done
with ANT). Set property `maven` to `true` to build with Maven.

Frank developers are encouraged not to use `context.xml` to configure
resources, but `resources.yml`. See
https://frank-manual.readthedocs.io/en/latest/deploying/database.html. Using
`context.xml` is still supported by the Frank!Runner though. Your project
doesn't need to contain a `resources.yml` or `context.xml` in case you want to use an
H2, Oracle, MSSQL or PostgreSQL database. By default
`frank-runner/database/h2/context.xml` will be used when your project doesn't
contain a `context.xml`. Use `database.type=oracle`, `mssql` or `postgresql` to use one
of the other `context.xml` files provided by the Frank!Runner.

The Frank!Runner expects `resources.yml` in the classes folder. If
`resources.yml` is not present, the Frank!Runner uses a property named
 `context.xml` for the location of this file that you can set in
 `frank-runner.properties` or `build.properties`. If there is a `pom.xml`
the default value for property `context.xml` is
`src/main/webapp/META-INF/context.xml`. Otherwise it is just
`context.xml`.

When changing files in the classes folder you need to restart Tomcat. When
changing files in the configurations folder you need to reload the configuration
in the Frank!Framework console (or restart Tomcat).

More information on Frank configuration files and Frank property files and how
to use them can be found in the
[Frank!Manual](https://frank-manual.readthedocs.io/).


# Project per config

In case your application comprises several Frank!Configurations and you would
like to have a project per configuration (e.g. to give each configuration it's
own CI/CD pipeline) the following setup is possible:

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
like to have a Maven module per configuration you can setup your project as
follows:

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
      |  |  |--pom.xml
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

The ear and war folders are optional and can also be placed inside a folder
named application that is on the same level as folder configurations.

The build.xml files for the modules need to have to following content (see
section [Installation](#installation) for the content of the build.xml that
can be added to the root of the project) (you can rename target restart to
restart-&lt;projectname&gt;-&lt;modulename&gt; to have better overview on the
Last Tasks list of the Task Explorer):

```
<project default="restart">
	<target name="restart">
		<basename property="project.dir" file="${basedir}/../.."/>
		<basename property="module.dir" file="${basedir}"/>
		<condition property="exe" value="../../../frank-runner/restart.bat" else="/bin/bash"><os family="windows"/></condition>
		<condition property="arg" value="../../../frank-runner/restart.sh" else=""><os family="unix"/></condition>
		<exec executable="${exe}" vmlauncher="false" failonerror="true">
			<arg value="${arg}"/>
			<arg value="-Dproject.dir=${project.dir}"/>
			<arg value="-Dmodule.dir=${module.dir}"/>
		</exec>
	</target>
</project>
```

This way every module can be started and tested on it's own running only the
configuration of this specific module. It is also possible to start other
configurations by adding the following:

```
	<arg value="-Dconfigurations.names=&quot;${module.dir},OtherModuleName,OtherConfigurationName&quot;"/>
```

When a Configuration.xml is detected in war/src/main/resources it is
automatically added to the list (this is also the case when
configurations.names is not specified and defaults to only the configuration of
one module).

See Frank2Example5 for example pom.xml files for the modules and the parent.


# Module per config flattened (aka monorepo)

When your modules contain an adapters folder this is automatically detected by
the Frank!Runner and the following setup is then expected (with the Maven
standard directory structure being flattened):

```
|--projects
   |--frank-runner
   |--frank2application
      |--application
      |  |--...
      |--configurations
      |  |--Example1
      |  |  |--adaters
      |  |  |  |--Configuration.xml
      |  |  |  |--...
      |  |  |--test
      |  |  |  |-...
      |  |  |--build.xml
      |  |  |--pom.xml
      |  |  |--restart.bat
      |  |  |--restart.sh
      |  |  |--...
      |  |--Example2
      |  |  |--...
      |  |--...
      |--build.xml
      |--pom.xml
      |--restart.bat
      |--restart.sh
```

Please be aware that the pom.xml files for the configurations need to tell
Maven to package the files from folder adapters instead of from the Maven
default folder src/main/resources. This can be configured in a parent pom to
configure it for all modules in the same file.

See [Module per config](#module-per-config) for information on how to start the
modules and for more information about the application, ear and war folder.



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

https://github.com/frankframework/frankframework/issues

We appreciate your help but in case you would like to use a more reliable
version and/or like to disable the update mechanism add the following to either
a build.properties in the frank-runner folder or a frank-runner.properties in
the root folder of your project:

```
update.strategy=stable
```

Or specify a specific Frank!Framework version like:

```
ff.version=7.4
```

Or:

```
ff.version=7.6-20200306.163142
```

Check the following url to find 8.0 and higher versions:

https://nexus.frankframework.org/service/rest/repository/browse/public/org/frankframework/frankframework-webapp/

Previous versions can be found at:

https://nexus.frankframework.org/service/rest/repository/browse/public/org/ibissource/ibis-adapterframework-webapp/


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

# Testing with DTAP stage different from LOC

Developers are adviced to test their work with `dtap.stage=LOC`, which is set
automatically by the Frank!Runner. There are situations however in which
another DTAP stage is needed during local development. The Frank!Framework
requires users to authenticate themselves when `dtap.stage` is not `LOC`,
and by default access is only possible through HTTPS in this case.
Here are example properties you can put in `frank-runner.properties` to do
development testing with `dtap.stage=DEV`:

    dtap.stage=DEV
    application.security.http.transportGuarantee=none
    application.security.console.authentication.type=IN_MEMORY
    application.security.console.authentication.username=ADMIN
    application.security.console.authentication.password=PASSWORD1234
    application.security.testtool.authentication.type=IN_MEMORY
    application.security.testtool.authentication.username=ADMIN
    application.security.testtool.authentication.password=PASSWORD1234

The line `application.security.http.transportGuarantee=none` tells the
Frank!Framework that access should be through HTTP instead of HTTPS.
The line `application.security.console.authentication.type=IN_MEMORY` tells
the Frank!Framework that it should hold a fixed username and a fixedpassword
in memory. With these settings, users get a login dialog and they can enter
with username `ADMIN` and password `PASSWORD1234`. The lines starting with
``application.security.testtool.authentication`` are to restrict access to
Ladybug.

Please note that the Frank!Runner does not support all the authentication
options provided by the Frank!Framework. The Frank!Runner is not designed
to support deployment in a production environment. In addition to
``IN_MEMORY``, authentication type ``YAML`` is supported. A ``localUsers.yml``
file added to the classes directory is found by the Frank!Runner. See
https://frank-manual.readthedocs.io/en/latest/advancedDevelopment/authorization/authorizationMethodsAndRoles.html
for details.

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

When you write a webapplication with Maven, your `pom.xml` file defines how the
application should be packaged. The Maven build is then typically what you need
for production. During local development, the Frank!Runner helps you to deploy
your application in Tomcat. The Frank!Runner then configures the following in
Tomcat, allowing you to omit it from your `pom.xml`:

* The Frank!Runner adds a database driver for the h2 database in Tomcat's `lib`
folder. The Frank!Runner also adds a `context.xml` to allow access to a h2
database.
* The Frank!Runner adds `geronimo-jms_1.1_spec.jar` to Tomcat's `lib` folder.
This file should not be packaged in your WAR because it should be provided by
application servers according to the Jakarta EE standard. Tomcat does not
provide this file however and hence this library has to be added.
* The Frank!Runner configures `catalina.properties` to define a scenarios root
directory for Larva. The Frank!Runner configures the absolute path to
`src/test/testtool`.
* The Frank!Runner configures in `cataline.properties` that `dtap.stage=LOC`.
This way, you can access your webapp through http during development. If you do
not set `dtap.stage` in your packaged application, it is up to the system
administrator of the user to configure `dtap.stage`.

# Root CA certificates

You may need to add your organistion's Root CA for Ant and Maven to be able to
download files from behind a Secure Web Gateway like Zscaler. This might also
be the case when your project needs to download files from your organization's
internal repository (e.g. Artifactory) or when you are running a Frank that is
doing http calls (e.g. when using HttpSender).

Usually you can find the certificate you need by visiting a public website in
a browser and view the security details of the url (click on the icon left to
the the url in the address bar). When viewing the certificate details export
the top certificate in the Certificate Hierarchy to a file. Create a folder
`cacerts` in the `frank-runner` folder, move the exported file to this folder
and (re)start the Frank!Runner.

The Frank!Runner will detect added and removed files from the `cacerts` folder
and reinstall all files in `cacerts` in the downloaded and unzipped JDK used by
the Frank!Runner. Also when the Frank!Runner's JDK version is changed and a new
JDK is downloaded Frank!Runner will install the Root CA's in the `cacerts`
folder in the newly downloaded and unzipped JDK.


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

https://github.com/frankframework/frankframework/blob/master/CONTRIBUTING.md#developing-with-eclipse

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

Remove \*\*/examples/\*\* from the "Task Explorer: Exclude" list or change it
to something like \*\*/examplesDISABLE/\*\* to be able to see the examples of
the Frank!Runner in the Task Explorer.

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
projects> git clone https://github.com/wearefrank/frank-runner
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

After this you should be able to run java, ant and mvn in this window.


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

# Troubleshooting

If something goes wrong using the Frank!Runner, the issue may be fixed by emptying the `download` and the `build` directory. This data is not refreshed every time the Frank!Runner starts. This behavior is useful to reduce the start-up time of the Frank!Runner, but occasionally the saved data causes trouble.
