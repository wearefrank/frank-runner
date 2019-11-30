# Run Ibis Configurations with Tomcat

This project will help you run your Ibis configuration(s) with Tomcat.

Basically all you have to do is to clone this project from within the same
folder that contains your Ibis project folder(s) (or clone to an empty folder
to start from scratch):

```
projects> git clone https://github.com/ibissource/tomcat4ibis
```

Change directory to tomcat4ibis:

```
projects> cd tomcat4ibis
```

And on Windows run the following command:

```
tomcat4ibis> ./tomcat4ibis.bat
```

When not using Windows run:

```
tomcat4ibis> ./tomcat4ibis.sh
```

When running this script for the first time it will ask you to download and
unzip two files. After doing so run the script again.

In case Java and Ant are available you can also run the build.xml to download
and unzip the files.

In case Eclipse is available you can also clone the Git project, run the
build.xml and run the tomcat4ibis.bat or tomcat4ibis.sh using Eclipse (you might
need to right click, Open With, System Editor).

You can now browse to the following address to find the Ibis4Tomcat4Ibis
console:

```
http://localhost/ibis
```

You can stop Tomcat using the following combination of keys: 

```
ctrl-c
```

By default the example configurations in tomcat4ibis will be used. To use
another project create a build.properties with the following content:

```
project.dir=Ibis4Example
```

In case this projects contains a pom.xml it is assumed to be a Maven project and
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
   |--Ibis4Example
      |--classes
      |--configurations
         |--Config1
         |--Config2
         |--Conf...
      |--tests
      |--context.xml
   |--Ibis4...
```

You can overwrite default values by creating tomcat4ibis.properties in the
project to run. In case you need to change the default value for projects.dir
(which is ..) you can create a build.properties in tomcat4ibis (which can also
be used to specify the project.dir as explained earlier).

When changing files in the classes folder you need to restart Tomcat. When
changing files in the configurations folder you need to reload the configuration
in the Ibis console (or restart Tomcat).

More information on Ibis configuration files and Ibis property files and how to
use them can be found in the Ibis manual which will soon be available.

# How to add custom jars and classes

In case you need to for example add you own pipe which is not available in the
Ibis Adapter Framework or you would like to customize an existing pipe in the
framework you can add a java folder to the project with you custom .java file.

For a Maven project the default value for the java folder is:

```
java.dir=src/main/java
```
Otherwise:

```
java.dir=java
```

For jar files create the following folder(s):


```
lib.server.dir=lib/server
lib.webapp.dir=lib/webapp
```

All jars in lib/server are added to the Tomcat lib folder. All jars in
lib/webapp are added to the WEB-INF/lib containing the Ibis Adapter Framework
jar files and dependencies.
