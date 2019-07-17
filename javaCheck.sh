#!/bin/bash -e

# Do Java check

if type -p java 1>/dev/null; then
#    echo Found Java in PATH
    _java=java
elif [[ -n "$JAVA_HOME" ]] && [[ -x "$JAVA_HOME/bin/java" ]];  then
#    echo Found Java in JAVA_HOME
    _java="$JAVA_HOME/bin/java"
else
    echo "Java not found. The Storage Client requires JDK 1.8"
    exit 1
fi

if [[ "$_java" ]]; then
    version=$("$_java" -version 2>&1 | awk -F '"' '/version/ {print $2}')
    # echo $version

    regex="^1?\.." #matches 1.xx java versioning    
    if [[ $version =~ $regex ]]; then 
        versionMajor=$(echo $version | awk -F '.' '{print $2}') 
    else
	    versionMajor=$(echo $version | awk -F '.' '{print $1}') 
    fi
    # echo $versionMajor
    
    if [[ $versionMajor -lt 11 ]]; then
        echo Java 11 required for SCORe Client. Current version is $version
        exit 1
    fi
fi
