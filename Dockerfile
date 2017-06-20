FROM ubuntu:16.04

# Get the basic tools we need
RUN apt-get update && apt-get upgrade -y
RUN apt-get -y install git-core

# Install the dependencies as documented
RUN apt-get -y install python3 python3-lxml python3-requests python3-requests-cache
RUN apt-get -y install livestreamer python-crypto
RUN apt-get -y install ffmpeg

# Cleanup after apt-get
RUN apt-get clean && apt-get purge && rm -rf /var/lib/apt/lists/*

# Webdl does not like running as root so setup a user & home dir
RUN useradd -ms /bin/bash webdl -d /home/webdl
RUN mkdir -p /home/webdl/data

# Grab webdl & pin to a commit for versioning
RUN cd /home/webdl && git clone https://bitbucket.org/delx/webdl
RUN cd /home/webdl/webdl && git reset --hard ef87849
RUN chown -R webdl:webdl /home/webdl

USER webdl
WORKDIR /home/webdl/data

CMD ["python3", "/home/webdl/webdl/autograbber.py", "/home/webdl/data", "/home/webdl/patterns.txt"]
