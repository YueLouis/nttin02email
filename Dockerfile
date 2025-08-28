FROM tomcat:10.1-jdk17-temurin

# Xóa apps mặc định để tránh trùng ROOT
RUN rm -rf /usr/local/tomcat/webapps/*

# Dùng WAR build sẵn của bạn làm ROOT
COPY nttin02email.war /usr/local/tomcat/webapps/ROOT.war

# Ghi đè cấu hình Tomcat bằng server.xml ở repo
COPY server.xml /usr/local/tomcat/conf/server.xml

# Khai báo port để Render tự phát hiện
EXPOSE 10000

CMD ["catalina.sh", "run"]
