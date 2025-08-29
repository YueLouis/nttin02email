FROM tomcat:9.0-jdk17

WORKDIR /usr/local/tomcat/webapps

COPY nttin02email.war ./ROOT.war

COPY server.xml /usr/local/tomcat/conf/server.xml

EXPOSE 8080  

CMD ["catalina.sh", "run"]