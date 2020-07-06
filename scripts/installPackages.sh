#!/bin/bash

apt-get update && apt-get upgrade
apt-get install -y \
	libprotobuf-dev \
	protobuf-compiler \
	libhdf5-serial-dev \
	liblmdb-dev \
	libleveldb-dev \
	libsnappy-dev \
	libgflags-dev \
	libgoogle-glog-dev \
	libatlas-base-dev

