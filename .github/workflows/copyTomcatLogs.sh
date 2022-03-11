#!/bin/bash

export TOMCAT_PATH=$(ls -d build/apache-tomcat*)
cp -R ${TOMCAT_PATH}logs ../../tomcatLogs
