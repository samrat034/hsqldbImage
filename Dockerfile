FROM openjdk:17

# Image Environment Variables
ENV HSQLDB_VERSION=2.6.1 \
    JAVA_VM_PARAMETERS= \
    HSQLDB_TRACE= \
    HSQLDB_SILENT= \
    HSQLDB_REMOTE= \
    HSQLDB_DATABASE_NAME= \
    HSQLDB_DATABASE_ALIAS= \
    HSQLDB_DATABASE_HOST= \
    HSQLDB_USER= \
    HSQLDB_PASSWORD= 

# Install Tooling

# RUN microdnf install wget
# RUN microdnf install unzip      
# Install HSQLDB
RUN mkdir -p /opt/database && \
    mkdir -p /opt/hsqldb && \
    chmod -R 777 /opt/database && \
    mkdir -p /scripts 
    #&& \
    # wget -O /opt/hsqldb-2.6.1.zip https://versaweb.dl.sourceforge.net/project/hsqldb/hsqldb/hsqldb_2_6/hsqldb-2.6.1.zip && \
    # unzip /opt/hsqldb-2.6.1.zip && \
    # cp ./hsqldb-2.6.1/hsqldb/lib/hsqldb.jar /opt/hsqldb/hsqldb.jar
    
    

# Clean caches and tmps
RUN rm -rf /tmp/* && \
    rm -rf /var/log/*

VOLUME ["/opt/database","/scripts"]
EXPOSE 9001

WORKDIR /scripts
COPY hsqldb.jar /opt/hsqldb/hsqldb.jar
COPY imagescripts/docker-entrypoint.sh /opt/hsqldb/docker-entrypoint.sh
ENTRYPOINT ["/opt/hsqldb/docker-entrypoint.sh"]
CMD ["hsqldb"]
