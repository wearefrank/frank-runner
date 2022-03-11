#!/bin/bash

echo "Running in directory $(pwd)"
export TOMCAT_PATH=$(find ../.. -name apache-tomcat* | grep -v "zip")
cp -R ${TOMCAT_PATH}logs ../../tomcatLogs
