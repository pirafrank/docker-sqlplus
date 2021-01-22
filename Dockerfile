FROM ubuntu

RUN apt-get -y update \
 && apt-get -y install libaio1 unzip rlwrap \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

ARG SQLPLUS_VERSION

COPY instantclient-*-${SQLPLUS_VERSION}.zip /opt/

WORKDIR /opt/
RUN unzip /opt/instantclient-basic-linux.x64-${SQLPLUS_VERSION}.zip \
 && unzip /opt/instantclient-sqlplus-linux.x64-${SQLPLUS_VERSION}.zip \
 && unzip /opt/instantclient-sdk-linux.x64-${SQLPLUS_VERSION}.zip \
 && unzip /opt/instantclient-jdbc-linux.x64-${SQLPLUS_VERSION}.zip \
 && rm -v /opt/instantclient-*-${SQLPLUS_VERSION}.zip \
 && mv -v /opt/instantclient* /opt/instantclient

COPY login.sql /opt/instantclient

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
CMD ["-V"]
