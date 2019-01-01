FROM ubuntu:18.04

# Install the dependencies as documented in the upstream readme
# + git-core for the clone performed later
RUN apt-get update -y && \
    apt-get -y install ffmpeg \
                       git-core \
                       livestreamer \
                       python-crypto \
                       python3 \
                       python3-lxml \
                       python3-requests \
                       python3-requests-cache && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/*

# Webdl does not like running as root so setup a user & home dir
RUN useradd -ms /bin/bash webdl -d /home/webdl && \
    mkdir -p /home/webdl/data

# Grab webdl & pin to a commit for versioning
RUN cd /home/webdl && \
    git clone https://bitbucket.org/delx/webdl && \
    cd /home/webdl/webdl && \
    git reset --hard 1b35304 && \
    chown -R webdl:webdl /home/webdl

USER webdl
WORKDIR /home/webdl/data

CMD ["python3", "/home/webdl/webdl/autograbber.py", "/home/webdl/data", "/home/webdl/patterns.txt"]
