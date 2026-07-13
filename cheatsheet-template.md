Cheatsheet for manually installing the Frank!Framework
======================================================

Download Apache Tomcat version @@tomcat.10.version@@ from @@tomcat.10.url@@. Download the Frank!Framework `.war` file and put it in Tomcat's `webapps` folder. Then put the following libraries in Tomcat's `lib` folder:

Description | Version | URL
----------- | ------- | ---
Geronimo | @@jta.version@@ | @@jta.url@@
Activation API | @@activation.version@@ | @@activation.url@@
Java Transaction API | @@transaction.version@@ | @@transaction.url@@
JMS driver (optional) | @@jms3.version@@ | @@jms3.url@@

You also need a database driver. The driver you need depends on the database brand. See the documentation of the Frank!Framework for details.
