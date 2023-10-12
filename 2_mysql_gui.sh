#!/bin/bash
# start phpmyadmin container using the official image
docker run -p 8083:80 \
--name phpmyadmin \
--link mysql:db \
-d phpmyadmin/phpmyadmin

# access it in the browser on
# localhost:8083

# login to phpmyadmin UI with either of 2 mysql user credentials:
# admin:adminpass
# root:rootpass