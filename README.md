How to make containers  Jenkins/Tomcat/Sonarqube/Postgresql work together by Docker-Compose

Important: Memory need setup at least 8GiB in Docker preferences for Running these containers.

1st: Please install docker engine in your computer (Windons/Linux/Unix/Mac...)

2nd: download latest version of Jenkins from dockerhub website

3nd downlaod latest version of sonarqube container

4th download latest version of postgresql database container.

5th : Please use the Dockerfile with context.xml and jenkins-tomcat.xml files to build container of Tomcat version 8.5

   Note: you can re-setup tomcat uer ID and password in file <jenkins-tomcat.xml>

6th: Run docker-compse with yaml file:

run command as following:

7: Build update version of Jenkins:

  $ docker pull jenkins

   copy Jenkins-Dockerfile and rename to Dockerfile in your working directory
   use command wget http://updates.jenkins-ci.org/download/war/2.168/jenkins.war 
   to get version 2.168 of Jenkins.war . Then build update version of Jenkins file
   Via docker build command :

   $ docker build -t jenkins:2.168  ./

8: $ docker pull sonarqube

9: $ docker pull postgres
10: $ docker build -t tomcat ./
11: $ docker-compose -f jtsp.yml up
12: Open Jenkins server: http://localhost:8180
13: Open Tomcat server: http://localhost:8280
14: Open SonarQube server: http://localhost:9000


=========================================
Configuring Jenkinks for Maven/Tomcat/Sonarqube/
·      Build your source code via Maven and automatically deploy to Tomcat Java server
·     Sonarqube Server will automatically check your source code of Bugs/ Vulnerablities / Code Smells
How to Build docker-compose , please reference at  https://github.com/ActiveHealth/ahm-devops-jenkins-maven-poc

Once everything is up and running docker-compose with containers in Jenkins; Tomcat; Sonarqube; Postgresql.  It is time to configure Jenkins.

1 Step
After run docker-compose up, it will show something like this:

After run docker-compose up, it will show something like this:
jenkins_1 | *************************************************************
jenkins_1 | *************************************************************
jenkins_1 | *************************************************************
jenkins_1 |
jenkins_1 | Jenkins initial setup is required. An admin user has been created and a password generated.
jenkins_1 | Please use the following password to proceed to installation:
jenkins_1 |
jenkins_1 | 74b08e697ce94956b9ef949832bxxxx
jenkins_1 |
jenkins_1 | This may also be found at: /var/jenkins_h
ome/secrets/initialAdminPassword
jenkins_1 |
jenkins_1 | *************************************************************
jenkins_1 | *************************************************************
jenkins_1 | *************************************************************
2 Step

Open your browser http://localhost:8180, it will ask for a password (the one that you copy on the 1º Step). Paste and click continue

3 Step
Jenkins will ask for which type of customization, choose Install Suggested Plugins.
   It will download and install all the required plugins and it may take some time.

4 Step
All the plugins are now installed, time to configure the default user.
  I recommend to use something basic and simple to remind, like admin/admin, it is a POC, not a production product. Remember, you will need it later on the process  Click Save and finish.

5 Step
Our Jenkins is up and running, but we need to make some configurations before start using.
  Go to Manage Jenkins on the left menu and them on Global Tool Configuration.

JDK
On the JDK section, click on Add JDK, choose a name (anything),
  uncheck the config Install automatically and fill the field JAVA_HOME with /docker-java-home

Maven
On the Maven section, click on Add Maven, choose a name (anything),
and let Install automatically checked. Hit apply Go to Manage Jenkins on the left menu once again and them on Manage Plugin. Click on the Available tab and them, on the search box, type deploy to container. It will show the plugin to install. Select it and click Install without restart And we are done with configuring Jenkins.


6 Step
Go to "Manage Jenkins" →   "Manage Plugin" → select "Available" → On Filter section type "SonarQube Scanner
 for Jenkins"  → Click "Install without restart"


7 Setp
Go to "Manage Jenkins"  →  "Configure System" →  "SonarQube servers" on Name section,
Enter any name you want, "sonarquber-server". In Server URL , type http://sonarqube:9000

8 Step

Go to "Manage Jenkins"  → "Global Tool Configuration"  →  "SonarQube Scanner",
select as below, Then select "Apply" and "Save"


Creating the first job

On the Jenkins home screen, click on New Item on the left menu. Choose a name
to the Job and select Freestyle Projectand hit ok.

On Source Code Management choose Git and paste the following URL on the
Repository URL: http://github.com/nzhang0430/test.git

This is the project that we want to build. On Build,
click on Add build step and choose "Invoke top-level Maven targets".

Select the Maven that you already configured and on Goals type "clean package".


On Build, click on Add build step  and choose "Execute SonarQube Scanner".
Enter below configure in"Analysis properties":


sonar.projectKey=webapp
sonar.projectName=webapp
sonar.projectVersion=1.0
#Path to Source
sonar.sources=/var/jenkins_home/workspace/$JOB_NAME/webapp/src

On Post-build actions, click on Add post-build actions and choose Deploy war/ear
to a container. On the field WAR/EAR files type "webapp/target/.war"
and in Context path type "webapp". On Add container, choose Tomcat 8.x.
On Credentials click on the add button and create a user with
jenkins as username and password. It will be required to the
deployment and them select the created user. On Tomcat URL{*}
type http://tomcat:8080 Hit save

Running the first build
Now that we made all the configs required, time to build the project for the first time.
Enter the created job and hit Build now.
The first time will be slower than the following builds, it will install all the required dependencies, don't worry.
If we have success on the build (blue dot).

To check source bugs on Sonarqube: http://localhost:9000
