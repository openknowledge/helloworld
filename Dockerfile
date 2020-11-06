FROM maven:3.6.3-jdk-11-openj9 AS mvn
COPY . /usr/src/root
WORKDIR /usr/src/root
#RUN echo nameserver 8.8.8.8 > /etc/resolv.conf && mvn clean package
RUN mvn clean package
FROM openjdk:8-jre
COPY --from=mvn /usr/src/root/target/hello-world-1.1.jar /opt/helloworld.jar
ENTRYPOINT exec java -cp /opt/helloworld.jar com.coveros.demo.helloworld.HelloWorld
