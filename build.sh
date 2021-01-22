#!/bin/bash

url='https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html'

function print_urls {
  # print files to download
  # you need to login with a free oracle account
  printf "%s\n%s\n" \
    "Download these files here first, then run this script again." \
    "A free Oracle account is required."
  curl -sSL $url | \
    grep -oP "\/\/[0-9A-Za-z_\-\.\/]*${SQLPLUS_VERSION}.zip" | \
    grep -P '(basic-linux|jdbc-linux|sdk-linux|sqlplus-linux)' | \
    sed -e 's@^@https:@g'
}

function check_files {
  NUM_OF_FILES=$(ls -1 | \
    grep "${SQLPLUS_VERSION}" | \
    grep -P '(basic-linux|jdbc-linux|sdk-linux|sqlplus-linux)' | \
    wc -l)
  if [ $NUM_OF_FILES -ne 4 ]; then
    print_urls
    exit 1
  fi
}

### MAIN ###

check_files

docker build \
  -f Dockerfile \
  --build-arg SQLPLUS_VERSION=$SQLPLUS_VERSION \
  -t pirafrank/docker-sqlplus:${SQLPLUS_VERSION} .

