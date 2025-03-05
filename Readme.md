# Oracle 19c Enterprise Edition - Docker Setup

## Introduction
This project provides a detailed guide on setting up and running Oracle 19 Enterprise Edition using Docker. It is intended for educational purposes to help users understand how to leverage Docker for Oracle database deployment.


## Disclaimer
⚠️ Important Notes:

- This project is intended for educational purposes only. It should not be used for any commercial activities or purposes that violate Oracle's licensing agreements.

- Do not misuse the information or resources provided in this project.

- Do not share any proprietary information obtained through this project with unauthorized parties.

- Respect the intellectual property rights of Oracle and other third parties.

- By using this project, you agree to comply with all applicable laws and regulations and to respect the rights of others.


## Contents
- [**Disclaimer**](#disclaimer)
- [**Prerequisites**](#prerequisites)
- [**Installation Steps**](#installation-steps)
- [**Connecting to the Database**](#connecting-to-the-database)

---
## Prerequisites
- **Operating System:** Linux-based OS, Windows, or macOS (Linux recommended for production).
- **Docker:** Docker Engine version 19.03 or later.
- **Hardware:** Minimum 4GB RAM, 20GB free disk space.

## Installation Steps
If you need to have [Docker](https://www.docker.com/products/docker-desktop/) installed in your device.

### Clone the repository
```bash
git clone https://github.com/albertmaharjan94/oracle-19-tutor-docker
cd oracle-19-tutor-docker
```
### Make sure you have the oracle Enterprise zip file from your `TUTOR` and place it in the same folder.
Proceed with
```bash
docker build -t oracle19c .
```

The initial docker build can take 5-10 minutues to build the oracle linux from scratch.
The the build is successful, run the following.
```bash
docker run  --name oracle-db --shm-size=4g -p 1521:1521 oracle19c 
```
This step will create a oracle SID called ORCL which can take 3-4 minutes. Wait for it to complete.

Once done, you can access the Oracle server using
```bash
docker exec -it oracle-db bash
```

You should be in `[oracle@<some_id> db_1]$` in default.

```bash
sqlplus sys/Pa55w0rd as sysdba;
```
Check the status of the database.
```sql
SELECT status FROM v$instance;
```
The status should be `OPEN`
You can change the HR user password

```sql
ALTER USER HR ACCOUNT UNLOCK;
ALTER USER HR IDENTIFIED BY HR_Pa55pA55;
```

# Connecting to the Database
If you are using [SQLTool](https://s3-np1.datahub.com.np/workshop/SQLTools_18b42.zip) client. Use the following credentials:

- TAG:
    ```bash
    HR
    ```

- User:
    ```bash
    HR
    ```
- Password:
    ```bash
    HR_Pa55pA55
    ```
- TCP Port:
    ```bash
    1521
    ```

- SID:
    ```bash
    ORCL
    ```

Test the connection first, save and then connect.
```sql
SELECT tname FROM tabs;
```