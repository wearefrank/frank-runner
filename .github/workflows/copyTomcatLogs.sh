#!/bin/bash

export TOMCAT_PATH=$(find ../.. -name apache-tomcat*)
cp -R ${TOMCAT_PATH}/logs ../../tomcatLogs
