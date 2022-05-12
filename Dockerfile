FROM ubuntu:xenial
RUN apt-get update && apt-get -y install \
                        gcc-arm-linux-gnueabihf \
                        g++-arm-linux-gnueabihf \
                        software-properties-common \
                        curl \
                        git \                                                                                                                                                                              
                        zlib1g-dev \
                        libffi-dev \
                        libxml2-dev \
                        libxslt-dev \
                        cmake
# Download and install Python 3.7
# Need to remove symlink from /usr/bin/python3 -> /usr/bin/python3.6
# so alinstall does not fail
RUN curl https://www.python.org/ftp/python/3.7.0/Python-3.7.0.tgz -O -J -L && \
    tar xzf Python-3.7.0.tgz -C /usr/src/ && \
    rm -f /usr/bin/python3 && \
    /usr/src/Python-3.7.0/configure --enable-optimizations --prefix=/usr/bin/python3 && \
    make altinstall && \
    ln -s /usr/bin/python3/bin/python3.7 /usr/bin/python3.7 && \
    rm Python-3.7.0.tgz

# set python3.7 as default
# RUN alternatives --install /usr/bin/unversioned-python python /usr/bin/python3.7 70
# RUN alternatives --set python /usr/bin/python3.7
# RUN ln -s /usr/bin/unversioned-python /usr/bin/python
# Add python binaries to the PATH
ENV PATH=/usr/bin/python3/bin:$PATH
