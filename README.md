# Run Ibis Configurations with Tomcat

This project will help you run your Ibis configurations with Tomcat.

Basically all you have to do is clone or download this project and run start.bat by
double clicking it and browse to the following address:

```
http://localhost/ibis
```

By default the example configurations in tomcat4ibis will be used. To use
another project create a build.properties in your tomcat4ibis directory with the
following content (assuming your ibis4myExample  project folder has the same parent
folder as the tomcat4ibis folder):

```
project.dir=ibis4myExample 
```

In case the ibis4myExample  project contains a pom.xml it is assumed to be a Maven project and
the following default values are used:

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
   |--tomcat4ibis
   |--ibis4myExample 
      |--classes
      |--configurations
         |--Config1
         |--Config2
         |--Conf...
      |--tests
      |--context.xml
   |--ibis4otherExample 
```

You can overwrite default values by creating tomcat4ibis.properties in the
project to run. In case you need to change the default value for projects.dir
(which is ..) you can create a build.properties in tomcat4ibis (which can also
be used to specify the project.dir as explained earlier).

Your project doesn't need to contain a context.xml in case you want to use H2.

When changing files in the classes folder you need to restart Tomcat. When
changing files in the configurations folder you need to reload the configuration
in the Ibis console (or restart Tomcat).

More information on Ibis configuration files and Ibis property files and how to
use them can be found in the Ibis manual which will soon be available.

# How to add custom jars and classes

In case you need to (for example) add your own pipe which is not available in the
Ibis Adapter Framework or you would like to customize an existing pipe in the
framework you can add a java folder to the project with your custom .java
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
to lib/webapp are copied to the WEB-INF/lib containing the Ibis Adapter
Framework jar files and dependencies.


# Eclipse

Right click on build.xml, Run As, Ant Build. The second time you can use the run
button on the Toolbar.


# VSCode

Install plugin Ant Target Runner and configure it to use ant.bat or any other
ant installation by adding the following to settings.json:

```
"ant.executable": "C:\\path\\to\\tomcat4ibis\\ant.bat",
```

Below the file explorer open de Ant Target Runner, select the restart target and
push the Run Selected Ant Target button.


# Command line

Execute the following commands from the command line:

```
projects> git clone https://github.com/ibissource/tomcat4ibis
```

Change directory to tomcat4ibis:

```
projects> cd tomcat4ibis
```

And on Windows run the following command:

```
projects\tomcat4ibis> run.bat
```

When not using Windows run:

```
projects\tomcat4ibis> ./run.sh
```

You can now browse to the following address to find the Ibis4Tomcat4Ibis
console:

```
http://localhost/ibis
```

You can stop Tomcat using the following combination of keys: 

```
ctrl-c
```


# Scripting

You can call tomcat4ibis from a script. Any parameter to tomcat4ibis is passed to
Ant and Tomcat. For instance, to create an instance with a specific ibis version 
(7.2 in the example), logging to a specific log directory, the following call can be made:

```
tomcat4ibis -Dibis.version=7.2 -Dlog.dir=logs/7.2
```

This will create the instance, deploy on tomcat, start tomcat and return to the script.
To shutdown the tomcat server, call shutdown:

```
shutdown
```
