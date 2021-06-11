FROM debian:latest
MAINTAINER BlackRose01<appdev.blackrose@gmail.com>

ENV DOMAINNAME localhost
ENV OPENOLAT_VERSION 1551
ENV OPENOLAT_UPDATE false
ENV TOMCAT_VERSION 9.0.46
ENV TOMCAT_UPDATE false
ENV INSTALL_DIR /opt/openolat

ENV DB_TYPE mysql
ENV DB_HOST 172.17.0.2
ENV DB_PORT 3306
ENV DB_NAME test-oo
ENV DB_USER test-oo
ENV DB_PASS test-oo
ENV LANG en_US.UTF-8
ENV LC_ALL C.UTF-8

COPY database/mysql.xml /tmp/mysql.xml
COPY database/postgresql.xml /tmp/postgresql.xml
COPY database/oracle.xml /tmp/oracle.xml
COPY database/sqlite.xml /tmp/sqlite.xml
COPY server.xml /tmp/server.xml
COPY olat.local.properties /tmp/olat.local.properties
COPY log4j2.xml /tmp/log4j2.xml
COPY entrypoint.sh /entrypoint.sh

RUN apt-get update
RUN apt-get dist-upgrade -y
RUN apt install -y default-jre default-jre-headless unzip curl wget locales
RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8
RUN chmod 0777 /entrypoint.sh

EXPOSE 8088/tcp

ENTRYPOINT ["/bin/bash"]
CMD ["-c", "/entrypoint.sh"]
