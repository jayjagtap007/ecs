FROM ubuntu:latest

MAINTAINER jayjagtap@gmail.com

RUN mkdir /opt/tomcat/
RUN apt-get update && apt-get install vim curl openjdk-11-jdk -y

WORKDIR /opt/tomcat
RUN curl -O https://mirrors.estointernet.in/apache/tomcat/tomcat-9/v9.0.43/bin/apache-tomcat-9.0.43.tar.gz
RUN tar xvfz apache-tomcat-9.0.43.tar.gz
RUN mv apache-tomcat-9.0.43/* /opt/tomcat/.
#RUN yum -y install java

#RUN java -version

WORKDIR /opt/tomcat/webapps
RUN curl -O -L https://github.com/AKSarav/SampleWebApp/raw/master/dist/SammpleWebApp.war
EXPOSE 80
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

