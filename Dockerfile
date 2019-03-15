From tomcat:8-jre8

#Maintainer
MAINTAINER "fzhang@activehealth.net"

#Copy below 2 files to docker container for build
COPY tomcat-users.xml /usr/local/tomcat/conf
COPY context.xml /usr/local/tomcat/webapps/manager/META-INF
