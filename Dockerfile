FROM ubuntu
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get -y install unzip
WORKDIR /opt/frank-runner
COPY build.xml ./
COPY *.sh ./
ADD database ./database

# Workaround for F!F 7.9-20230623.190015 (remove when newer version with fix available)
RUN echo "ignore.double.jars=true" > build.properties

RUN ./ant.sh -version
WORKDIR /opt
