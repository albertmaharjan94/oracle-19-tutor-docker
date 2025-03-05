#!/bin/bash

echo "Starting Oracle Database..."

export ORACLE_BASE=/u01/app/oracle
export PATH=$ORACLE_HOME/bin:$PATH
export ORADATA=/u01/app/oracle/oradata
export ORACLE_BASE=/u01/app/oracle
export ORACLE_HOME=/u01/app/oracle/product/19c/db_1
export ORACLE_UNQNAME=oracle
export ORACLE_SID=ORCL
export LD_LIBRARY_PATH=$ORACLE_HOME/lib
export AWT_TOOLKIT=XToolkit
export TEMP=/tmp
export TMPDIR=/tmp

echo "Oracle environment variables set successfully."

mkdir -p /u01/app/oracle/admin/orcl/adump
chown -R oracle:oinstall /u01/app/oracle/admin/orcl/adump
chmod -R 750 /u01/app/oracle/admin/orcl/adump





# # Check if Database Exists
if [ ! -f "$ORADATA/system01.dbf" ]; then
    echo "Creating a new database..."
    dbca -silent -createDatabase \
        -gdbName ORCL \
        -templateName General_Purpose.dbc \
        -characterSet AL32UTF8 \
        -memoryPercentage 60 \
        -emConfiguration NONE \
        -datafileDestination $ORADATA \
        -redoLogFileSize 30 \
        -storageType FS \
        -ignorePreReqs \
        -sysPassword "Pa55w0rd" \
        -systemPassword "Pa55w0rd"

else
    echo "Database already exists."
fi

# Start Listener
lsnrctl start


# # Wait for listener to be available
echo "Waiting for listener to start..."
sleep 5


echo "CREATING HR SCHEMA"

export ORACLE_SID=ORCL
sqlplus sys/password as SYSDBA <<EOF
@?/demo/schema/human_resources/hr_main.sql;
EOF

# Keep container running
tail -f /dev/null
