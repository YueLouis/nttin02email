FROM tomcat:10.1-jdk17-temurin
RUN rm -rf /usr/local/tomcat/webapps/*
COPY nttin02email.war /usr/local/tomcat/webapps/nttin02email.war
EXPOSE 8080
CMD ["catalina.sh","run"]
