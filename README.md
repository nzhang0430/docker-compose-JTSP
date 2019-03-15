These are docker containers of Jenkins/Tomcat/Sonarqube/Postgresql work together by Docker-Compose

Important: Memory need setup at least 8GiB in Docker preferences for Running these containers.

1st: Please install docker engine in your computer (Windons/Linux/Unix/Mac...)

2nd: download latest version of Jenkins from dockerhub website

3nd downlaod latest version of sonarqube container

4th download latest version of postgresql database container.

5th : Please use the Dockerfile with context.xml and jenkins-tomcat.xml files to build container of Tomcat version 8.5

   Note: you can re-setup tomcat uer ID and password in file <jenkins-tomcat.xml>

6th: Run docker-compse with yaml file:
run command as following:

7: $ docker pull jenkins/jenkins:latest
8: $ docker pull sonarqube
9: $ docker pull postgresql
10: $ docker build -t tomcat ./
11: $ docker-compose -f jtsp.yml up
12: Open Jenkins server: http://localhost:8180
13: Open Tomcat server: http://localhost:8280
14: Open SonarQube server: http://localhost:9000
