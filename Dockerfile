# Dựa trên Tomcat 10 + JDK 17
FROM tomcat:10.1-jdk17

# Tomcat phải nghe đúng PORT của Render
COPY server.xml /usr/local/tomcat/conf/server.xml

# 1) Copy resource tĩnh & JSP vào ROOT context
COPY src/main/webapp/ /usr/local/tomcat/webapps/ROOT/

# 2) Copy nguồn Java và biên dịch vào WEB-INF/classes
COPY src/main/java/ /tmp/src/
RUN mkdir -p /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
 && find /tmp/src -name "*.java" > /tmp/sources.txt \
 && javac -encoding UTF-8 \
    -classpath "/usr/local/tomcat/lib/*" \
    -d /usr/local/tomcat/webapps/ROOT/WEB-INF/classes \
    @/tmp/sources.txt \
 && rm -rf /tmp/src /tmp/sources.txt

CMD ["catalina.sh","run"]
