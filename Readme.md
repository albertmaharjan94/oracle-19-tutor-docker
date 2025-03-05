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

You can use the following alternatives to build oracle project.
⚠️ Donot proceed if you have completed the docker setup from above.

# Docker Compose
```bash
docker compose up -d --build
```

The following will be installed
- Oracle 19c Enterprise
- Dbeaver

Wait for 5-10 minutes to build the whole process 
Go to the following URL to Setup Dbeaver and proceed to continue.
```bash
http://localhost:8086
```
Start the setup
![image](https://github.com/user-attachments/assets/59f910e6-4f41-4f3b-b4c3-c868cedc6072)
Configure the Initial Configuration
![image](https://github.com/user-attachments/assets/fdd965fc-7220-48f5-a55f-2c9d03425ee6)
Finish the setup
![image](https://github.com/user-attachments/assets/9c4eb21d-e5c7-4848-a754-5428583eb352)

Create a Oracle Connection, if you donot see the following, refresh the page again.
![image](https://github.com/user-attachments/assets/bf1e8e9b-1719-4d37-91a9-8f2eb6fec399)

Add a new connection
![image](https://github.com/user-attachments/assets/0eb97a00-35a0-4674-961f-1efc50c94e4d)

Select Oracle
![image](https://github.com/user-attachments/assets/27d131a8-812a-4881-a4eb-4f618e747cf0)

Fill the following Credentials
![image](https://github.com/user-attachments/assets/ab31d173-5d2c-4d52-9962-da1f05e99dd9)


- HOST:
    ```bash
    oracle-db
    ```
    This refers to the oracle container name. If you have server IP you can put the server IP.
- PORT:
    ```bash
    1521
    ```
- USERNAME:
    ```bash
    HR
    ```
- PASSWORD:
    ```bash
    HR_Pa55pA55
    ```
- DATABASE:
    ```bash
    ORCL
    ```
- SERVICE TYPE:
    ```bash
    SID
    ```
