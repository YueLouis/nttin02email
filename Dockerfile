FROM tomcat:10.1-jdk17

# dọn app mặc định của tomcat
RUN rm -rf /usr/local/tomcat/webapps/*

# copy WAR của mình thành ROOT.war (app chạy ở "/")
COPY nttin02email.war /usr/local/tomcat/webapps/ROOT.war

# Render đặt PORT động (vd 10000). Sửa conf/server.xml lúc khởi động rồi chạy Tomcat
CMD sh -c 'sed -ri "s/port=\"8080\"/port=\"${PORT}\"/" /usr/local/tomcat/conf/server.xml && catalina.sh run'
