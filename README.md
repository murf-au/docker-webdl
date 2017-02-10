# docker-webdl

A Docker image for running webdl [delx/webdl](https://bitbucket.org/delx/webdl).

## Building

    docker build . -t tastle/webdl:latest

## Running

Webdl supports two modes, see [delx/webdl README.md](https://bitbucket.org/delx/webdl) for full details.

1. Automatic - download everything matching the globs in patterns.txt
2. Interactive - manually browse, select and download programs.

**Note:** 

* All of the following expect to be run from the root of this repo.
* Programs will be downloaded to the ```./data```directory on the Docker host.

### Run Automatic Mode - autograbber.py (default):

I suggest you edit ```patterns.txt``` first unless you like [Play School](http://www.abc.net.au/abcforkids/sites/playschool/).

#### Using docker-compose

    docker-compose up

#### Using docker run

    docker run --rm -v `pwd`/data:/home/webdl/data:rw -v `pwd`/patterns.txt:/home/webdl/patterns.txt:ro tastle/webdl

### Run Interactive Mode - grabber.py

    docker run --rm -ti -v `pwd`/data:/home/webdl/data:rw tastle/webdl python3 /home/webdl/webdl/grabber.py
