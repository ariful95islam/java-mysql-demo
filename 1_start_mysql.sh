#!/bin/bash
# start mysql container using docker
docker run -p 3306:3306 \
--name mysql \
-e MYSQL_ROOT_PASSWORD=rootpass \
-e MYSQL_DATABASE=team-member-projects \
-e MYSQL_USER=admin \
-e MYSQL_PASSWORD=adminpass \
-d mysql mysqld --default-authentication-plugin=mysql_native_password

# create java jar file
gradle build

# set env vars in Terminal for the java application (these will read in DatabaseConfig.java)
export DB_USER=admin
export DB_PWD=adminpass
export DB_SERVER=localhost
export DB_NAME=team-member-projects

# start java application
java -jar build/libs/docker-exercises-project-1.0-SNAPSHOT.jar