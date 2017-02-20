#!/bin/sh
VERSION_DATE=2015
PROJECT_NAME=gmxx
TOMCAT_HOME=/data/tomcat-gmxx
SRC_PATH=$TOMCAT_HOME/tmp/$PROJECT_NAME/$PROJECT_NAME

cd $SRC_PATH
echo egin src sync
svn up>>/data/logs/svn.log
echo egin mvn
rm -rf $TOMCAT_HOME/webapps/ROOT
rm -rf $TOMCAT_HOME/tmp/$PROJECT_NAME/$PROJECT_NAME.war
mvn clean  -Dmaven.test.skip=true
mvn compile -U -Dmaven.test.skip=true -P production
mvn package  -Dmaven.test.skip=true -P production
cp $SRC_PATH/target/$PROJECT_NAME.war $TOMCAT_HOME/tmp/$PROJECT_NAME/

${TOMCAT_HOME}/bin/catalina.sh stop
cp ${TOMCAT_HOME}/tmp/$PROJECT_NAME/ROOT.xml ${TOMCAT_HOME}/conf/Catalina/localhost/
${TOMCAT_HOME}/bin/catalina.sh start

echo uccess 

