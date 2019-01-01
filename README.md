# docker-webdl

[![Docker Build](https://img.shields.io/docker/automated/trastle/webdl.svg)](https://hub.docker.com/r/trastle/webdl/)

[WebDL](https://bitbucket.org/delx/webdl) is a set of Python scripts to grab video from online Free To Air Australian channels for offline viewing.

This repo provides a Docker Image for running webdl.

## Building

    docker build . -t trastle/webdl:latest

## Running

Webdl supports two modes, see [delx/webdl README.md](https://bitbucket.org/delx/webdl) for full details.

1. Automatic - download everything matching the globs in patterns.txt
2. Interactive - manually browse, select and download programs.

### Run Automatic Mode - autograbber.py (default):

1. Create a data directory for your downloads

        mkdir data
        
2. Create ```patterns.txt``` with the programs you want to download

        echo "ABC iView/By Channel/ABC4Kids/Play School/*" > patterns.txt

3. Run the container

        docker run --rm -v `pwd`/data:/home/webdl/data:rw -v `pwd`/patterns.txt:/home/webdl/patterns.txt:ro trastle/webdl

### Run Interactive Mode - grabber.py

1. Create a data directory for your downloads

        mkdir data
        
2. Run the container

        docker run --rm -ti -v `pwd`/data:/home/webdl/data:rw trastle/webdl python3 /home/webdl/webdl/grabber.py
