FROM ubuntu
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get -y install unzip
WORKDIR /opt/frank-runner
COPY build.xml ./
COPY *.sh ./
ADD database ./database
RUN ./ant.sh -version
WORKDIR /opt
