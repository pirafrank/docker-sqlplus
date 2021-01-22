# Oracle SQL*Plus

Docker image for oracle SQL*Plus with instant client

Forked from loivis/sqlplus to add:

- support build of multiple client versions
- docker mountpoints (e.g. for .sql scripts)

## How to build

```
git clone https://github.com/pirafrank/docker-sqlplus.git
cd docker-sqlplus

# set the env var with one of the versions available here:
# https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
export SQLPLUS_VERSION=x.x.x.x

./build.sh

# and follow the instructions
```

## How to run

```
docker run --rm -it -v /some/dir:/some/path pirafrank/docker-sqlplus:${SQLPLUS_VERSION}
sqlplus user/passwd@//host:1521/SID
```

