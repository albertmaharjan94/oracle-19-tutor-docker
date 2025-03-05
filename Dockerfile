# Use Oracle Linux as base
FROM oraclelinux:8

# Set environment variables
ENV ORACLE_BASE=/u01/app/oracle
ENV ORACLE_HOME=$ORACLE_BASE/product/19c/db_1
ENV ORACLE_INVENTORY=/u01/app/oraInventory
ENV ORACLE_SID=ORCL
ENV PATH=$ORACLE_HOME/bin:$PATH
ENV ORADATA=/u01/app/oracle/oradata
ENV CV_ASSUME_DISTID=OL7

# Install dependencies
RUN yum install -y oracle-database-preinstall-19c \
    unzip vim net-tools openssl \
    && yum clean all

# Create necessary directories
RUN mkdir -p $ORACLE_HOME && \
    mkdir -p $ORACLE_INVENTORY && \
    mkdir -p $ORADATA && \
    mkdir -p /u01/app/oracle/admin/ORCL/adump && \
    chown -R oracle:oinstall /u01/app && \
    chmod -R 775 /u01/app

# Copy Oracle installer zip and response file
COPY V982063-01-Database.zip /u01/app/oracle/
COPY db_install.rsp /u01/app/oracle/db_install.rsp

# Change ownership to Oracle user
RUN chown -R oracle:oinstall /u01/app

# Switch to Oracle user
USER oracle

# Unzip Oracle Database installer
RUN unzip /u01/app/oracle/V982063-01-Database.zip -d $ORACLE_HOME

WORKDIR $ORACLE_HOME
# RUN ./runInstaller -silent -responseFile /u01/app/oracle/db_install.rsp -ignorePrereq -waitforcompletion
RUN ./runInstaller -silent -responseFile /u01/app/oracle/db_install.rsp -ignorePrereq -waitforcompletion &> install.log & \
    INSTALL_PID=$! && \
    tail -f install.log | while ! grep -q "execute the following script(s)"; do sleep 5; done

# Switch back to root to execute the required scripts
USER root
RUN /u01/app/oraInventory/orainstRoot.sh && \
    /u01/app/oracle/product/19c/db_1/root.sh && \
    wait $INSTALL_PID


# Copy startup script
# COPY entrypoint.sh /u01/app/oracle/entrypoint.sh
# RUN chmod +x /u01/app/oracle/entrypoint.sh

COPY entrypoint.sh /u01/app/oracle/entrypoint.sh
RUN chmod 755 /u01/app/oracle/entrypoint.sh

RUN chown oracle:oinstall /u01/app/oracle/entrypoint.sh

COPY listener.ora /u01/app/oracle/product/19c/db_1/network/admin/
COPY sqlnet.ora /u01/app/oracle/product/19c/db_1/network/admin/
COPY tnsnames.ora /u01/app/oracle/product/19c/db_1/network/admin/

# Expose Oracle ports
EXPOSE 1521 5500

# Start Oracle Database & Listener
USER oracle
ENTRYPOINT ["/u01/app/oracle/entrypoint.sh"]