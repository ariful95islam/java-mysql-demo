# Java-MySQl Application using Docker Containers

This repository contains a Java-MySQL application which can be deployed using K8s locally. 

## Directory Structure

- `/src`: Contains the application code
- `build.gradle`: Build file via gradle
- `settings.gradle`: Settings file for gradle.

## Prerequisites

- [Docker installed](https://www.simplilearn.com/tutorials/docker-tutorial/how-to-install-docker-on-ubuntu)
- [minikube installed](https://minikube.sigs.k8s.io/docs/start/)
- [helm installed](https://helm.sh/docs/intro/install/)
- [helmfile installed](https://github.com/helmfile/helmfile)

## Instructions
#### There are many different ways to run the application which are listed below

1. **Start Minikube**:
```bash
minikube start #default driver is docker add --driver=hyperkit for hyperkit
```
- This will start via docker driver 
- --driver=hyperkit will run minikube on macos

2. **MySQL with replicas on local k8s**:
```bash
helm install my-release bitnami/mysql -f mysql-chart-values-minikube.yaml
```
- The above yaml provides some default values to be passed in with the deployment

3. **Deploy the Java App with 3 replicas**:
```bash
DOCKER_REGISTRY_SERVER=docker.io
DOCKER_USER=your dockerID, same as for `docker login`
DOCKER_EMAIL=your dockerhub email, same as for `docker login`
DOCKER_PASSWORD=your dockerhub pwd, same as for `docker login`

kubectl create secret docker-registry my-registry-key \
--docker-server=$DOCKER_REGISTRY_SERVER \
--docker-username=$DOCKER_USER \
--docker-password=$DOCKER_PASSWORD \
--docker-email=$DOCKER_EMAIL

kubectl apply -f db-secret.yaml
kubectl apply -f db-config.yaml
kubectl apply -f java-app.yaml
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

4. **Optional - Deploy phpmyadmin for database gui**:
```bash
kubectl apply -f phpmyadmin.yaml
```

4. **Create Ingress rule for domain name access**:
- If you want users to access the application via domain name you will need to create an ingress rule, which requires deploying Ingress Controller (Load Balancer)
```bash
minikube addons enable ingress
```
- set the host name in java-app-ingress.yaml line 9 to my-java-app.com
- get minikube ip address with command minikube ip, example: 192.168.64.27
- add ```bash 192.168.64.27 my-java-app.com``` in /etc/hosts file (use sudo or vim)
- create ingress component: kubectl apply -f java-app-ingress.yaml
- access application from browser on address: my-java-app.com

5. **Acessing phpmyadmin via portforward**:
- Step 4 allowed you to gain access to the java-app via a domain name 
- However, the database gui doesn't need an ingress configuration as it is not designed to be easily accessible by a user
- You can use portforwarding to open up access for you local machine via:
```bash
kubectl port-forward svc/phpmyadmin-service 8081:8081
```
- And then access it via http://localhost:8081

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
