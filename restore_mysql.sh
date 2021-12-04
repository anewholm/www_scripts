#!/bin/bash
# requirements:
# database server is mysql and assumed to be on the same box and running
# webs server is Apache2 standard location
# run in the root of the wordpress installation
mysql_username=root

# --------------------------------- checks
if [ -z $1 ]; then
  echo "ERROR: \$1 parameter (database, e.g. tnv3) required"
  exit 1;
fi
if [ -z $2 ]; then
  echo "ERROR: \$2 parameter (root password) required"
  exit 1;
fi
if [ -z $3 ]; then
  echo "ERROR: \$3 parameter (.sql file) required"
  exit 1;
fi
if ! ps -A | grep -q mysqld; then
  echo "ERROR: mysqld not running on this server"
  exit 1;
fi

mysql -u $mysql_username --password=$2 $1 < $3

