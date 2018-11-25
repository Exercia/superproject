#!/bin/bash
docker run --name webserver -it -p 80:80 -p 22:22 -p 443:443 webserver
