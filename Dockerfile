# Chạy Tomcat 10 + JDK 17
FROM tomcat:10.1-jdk17

# Xoá app mẫu
RUN rm -rf /usr/local/tomcat/webapps/*

# Dùng cấu hình server.xml để Tomcat bind vào $PORT
COPY server.xml /usr/local/tomcat/conf/server.xml

# Copy WAR của bạn thành ROOT.war để app chạy ở "/"
# Nếu file .war của bạn tên khác thì sửa lại cho khớp.
COPY nttin02email.war /usr/local/tomcat/webapps/ROOT.war

# Chạy Tomcat
CMD ["catalina.sh","run"]
