# Java-MySQL Application using Docker Containers

This repository contains a Java-MySQL application which can be deployed using Docker. 

## Directory Structure

- `/src`: Contains the application code
- `build.gradle`: Build file via gradle
- `settings.gradle`: Settings file for gradle.

## Prerequisites

- Docker installed
- [How to install Docker on Linux](https://www.simplilearn.com/tutorials/docker-tutorial/how-to-install-docker-on-ubuntu)


## Instructions
#### There are many different ways to run the application which are listed below

1. **Set Up MySQL for your App**:
- To simply run that application you will need to also start a MySQL container
- 1_start_mysql.sh will build and run your java app as well as start the mysql container
- REMEMBER TO CHANGE CREDENTIALS

2. **GUI for MySQL**:
- You might want to see the database data using a UI tool. You can deploy phpmyadmin as a container with 2_mysql_gui.sh
- REMEMBER TO CHANGE CREDENTIALS

3. **Deploying MySQL Database and GUI together using docker compose**:
```bash
docker-compose -f docker-compose.yaml up    
```
- If going down this route - you will need to then run the java app
```bash
gradle build
export DB_USER=admin
export DB_PWD=adminpass
export DB_SERVER=localhost
export DB_NAME=team-member-projects
java -jar build/libs/docker-exercises-project-1.0-SNAPSHOT.jar
```
- REMEMBER TO CHANGE CREDENTIALS TO MATCH MySQL DB

4. **Dockerize Java App and push to Image Repository like DockerHUB or ECR**:
```bash
# You can inspect and/or configure the Dockerfile before doing the below

# create jar file - bootcamp-java-mysql-project-1.0-SNAPSHOT.jar
gradle build

# create docker image - {repo-name}/{image-name}:{image-tag}
docker build -t {repo-name}/java-app:1.0-SNAPSHOT .

# push docker to remote docker repo {repo-name}
docker push {repo-name}/java-app:1.0-SNAPSHOT
```

4. **Add Java App image to docker-compose**:
- Now that the Java App is an image you can add it to docker-compose and run all three containers together!
```bash
# set all needed environment variables
export DB_USER=admin
export DB_PWD=adminpass
export DB_SERVER=mysql
export DB_NAME=team-member-projects
export MYSQL_ROOT_PASSWORD=rootpass
export PMA_HOST=mysql
export PMA_PORT=3306
docker-compose -f docker-compose-with-app.yaml up
```
- REMEMBER TO CHANGE VARIABLES TO MATCH YOUR CONFIGURATION

## Cleanup

To stop a container separately:
```bash
docker stop [container id]
```

To stop a container using docker-compose:
```bash
docker-compose -f docker-compose.yaml down
```

## Contributions

Feel free to raise issues or pull requests if you wish to contribute to the infrastructure or application configurations.
