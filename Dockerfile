FROM ubuntu:trusty

MAINTAINER Daryl Walleck <daryl.walleck@rackspace.com>

RUN apt-get update

RUN apt-get install -qqy make build-essential python-dev libffi-dev libssl-dev git

RUN apt-get install -qqy python python-pip

# Setup devstack user
RUN mkdir -p /opt; \
  useradd -m -s /bin/bash -d /opt/stacktester stacktester

RUN git clone https://github.com/openstack/tempest /opt/stacktester/tempest

WORKDIR /opt/stacktester/tempest

RUN pip install -r requirements.txt

RUN pip install os-testr

RUN testr init

ADD .testr.conf /opt/stacktester/tempest/
