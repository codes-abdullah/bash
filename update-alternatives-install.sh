#!/bin/bash

sudo update-alternatives --install "/usr/bin/java" "java" "${JAVA_HOME}/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac" "java" "${JAVA_HOME}/bin/javac" 1

sudo update-alternatives --install "/usr/bin/java_n" "java_n" "${JAVA_NEW_HOME}/bin/java" 1
sudo update-alternatives --install "/usr/bin/javac_n" "javac_n" "${JAVA_NEW_HOME}/bin/javac" 1
sudo update-alternatives --install "/usr/bin/jshell" "jshell" "${JAVA_NEW_HOME}/bin/jshell" 1

