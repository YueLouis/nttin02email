FROM tomcat:10.1-jdk17

# Gỡ webapps mặc định
RUN rm -rf /usr/local/tomcat/webapps/*

# server.xml để Tomcat bind đúng PORT Render cấp
COPY server.xml /usr/local/tomcat/conf/server.xml

# Deploy app làm ROOT (đường dẫn là /)
COPY nttin02email.war /usr/local/tomcat/webapps/ROOT.war

# Giữ encoding UTF-8
ENV JAVA_OPTS="-Dfile.encoding=UTF-8 -Dsun.jnu.encoding=UTF-8"

# (không bắt buộc) khai báo cho rõ
EXPOSE 10000

CMD ["catalina.sh","run"]
