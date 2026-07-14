Cheatsheet for manually installing the Frank!Framework
======================================================

DISCLAIMER: This cheatsheet should not be applied for production environments. Web applications using the Frank!Framework should take care of authorization and life cycle management. This requires extensive knowledge of Tomcat that is not covered here. Even integration specialists with advanced Tomcat knowledge should not manually install Apache Tomcat to deploy the Frank!Framework. Integration specialists should use the Docker image provided by the maintainers of the Frank!Framework. The maintainers of the Frank!Framework have taken care of relevant security and life cycle management aspects. This cheatsheet is only intended for students of the Frank!Academy who want to understand the technologies behind the Frank!Framework. Integration specialists who build prototypes or development versions of applications should use the Frank!Runner to configure Tomcat as is explained in the [README](README.md).

Download Apache Tomcat version 10.1.55 from https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.55/bin/apache-tomcat-10.1.55.zip. Download the Frank!Framework `.war` file and put it in Tomcat's `webapps` folder. Then put the following libraries in Tomcat's `lib` folder:

Description | Version | URL
----------- | ------- | ---
Geronimo | 1.1.1 | https://repo1.maven.org/maven2/org/apache/geronimo/specs/geronimo-jta_1.1_spec/1.1.1/geronimo-jta_1.1_spec-1.1.1.jar
Activation API | 2.1.4 | https://repo1.maven.org/maven2/jakarta/activation/jakarta.activation-api/2.1.4/jakarta.activation-api-2.1.4.jar
Java Transaction API | 2.0.1 | https://repo1.maven.org/maven2/jakarta/transaction/jakarta.transaction-api/2.0.1/jakarta.transaction-api-2.0.1.jar
JMS driver (optional) | 3.1.0 | https://repo1.maven.org/maven2/jakarta/jms/jakarta.jms-api/3.1.0/jakarta.jms-api-3.1.0.jar

You also need a database driver. The driver you need depends on the database brand. See the documentation of the Frank!Framework for details.
