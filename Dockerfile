FROM ubuntu:20.04 as git

RUN apt-get update -y && \
    apt-get --no-install-recommends -y install git

ENV GIT_SSL_NO_VERIFY=1

# Grab webdl & pin to a commit for versioning
RUN git clone https://bitbucket.org/delx/webdl /webdl && \
    cd /webdl && \
    git reset --hard 5ad7c98

FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Install the dependencies as documented in the upstream readme
# + git-core for the clone performed later
RUN apt-get update -y && \
    apt-get --no-install-recommends -y install ffmpeg \
                       python3 \
                       python3-lxml \
                       python3-pip \
                       python3-requests \
                       python3-requests-cache \
                       streamlink && \
    apt-get clean && \
    apt-get purge && \
    rm -rf /var/lib/apt/lists/*

# Webdl does not like running as root so setup a user & home dir
RUN useradd -ms /bin/bash webdl -d /home/webdl && \
    mkdir -p /home/webdl/data

COPY --from=git /webdl /home/webdl/.

# Install any python requirements Webdl lists
RUN pip3 install -r /home/webdl/requirements.txt

# RUN chown -R webdl:webdl /home/webdl
# USER webdl
WORKDIR /home/webdl/data

CMD ["python3", "/home/webdl/autograbber.py", "/home/webdl/data", "/home/webdl/patterns.txt"]
