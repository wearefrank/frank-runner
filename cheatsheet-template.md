Cheatsheet for manually installing the Frank!Framework
======================================================

DISCLAIMER: This cheatsheet should not be applied for production environments. Web applications using the Frank!Framework should take care of authorization and life cycle management. This requires extensive knowledge of Tomcat that is not covered here. Even integration specialists with advanced Tomcat knowledge should not manually install Apache Tomcat to deploy the Frank!Framework. Integration specialists should use the Docker image provided by the maintainers of the Frank!Framework. The maintainers of the Frank!Framework have taken care of relevant security and life cycle management aspects. This cheatsheet is only intended for students of the Frank!Academy who want to understand the technologies behind the Frank!Framework. Integration specialists who build prototypes or development versions of applications should use the Frank!Runner to configure Tomcat as is explained in the [README](README.md).

Download Apache Tomcat version @@tomcat.10.version@@ from @@tomcat.10.url@@. Download the Frank!Framework `.war` file and put it in Tomcat's `webapps` folder. Then put the following libraries in Tomcat's `lib` folder:

Description | Version | URL
----------- | ------- | ---
Geronimo | @@jta.version@@ | @@jta.url@@
Activation API | @@activation.version@@ | @@activation.url@@
Java Transaction API | @@transaction.version@@ | @@transaction.url@@
JMS driver (optional) | @@jms3.version@@ | @@jms3.url@@

You also need a database driver. The driver you need depends on the database brand. See the documentation of the Frank!Framework for details.
