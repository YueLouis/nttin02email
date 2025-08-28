FROM tomcat:10.1-jdk17-temurin

# Bỏ các app mặc định để tránh chiếm ROOT
RUN rm -rf /usr/local/tomcat/webapps/*

# Dùng cấu hình server.xml của mình
COPY server.xml /usr/local/tomcat/conf/server.xml

# Deploy WAR của em làm ROOT để URL là /survey
COPY nttin02email.war /usr/local/tomcat/webapps/ROOT.war

# (Metadata thôi, Render không dùng EXPOSE để map cổng)
EXPOSE 10000

CMD ["catalina.sh", "run"]
