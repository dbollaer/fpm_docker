
# Use osixia/light-baseimage
# https://github.com/osixia/docker-light-baseimage
FROM debian:jessie
MAINTAINER Danny Bollaert <Danny.Bollaert@ugent.be>

# Download nginx from apt-get and clean apt-get files
RUN apt-get -y update \
    && LC_ALL=C DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
       nginx \
   && apt-get clean \
   && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV FPM_DEPS \
	    openssl \
	    git \
	    unzip \
	    devscripts \
	    build-essential \
	    lintian \
	    ruby-dev \
	    rubygems \
	    gcc \ 
	    make \
	    libffi-dev

RUN apt-get update && apt-get install -y \
		$FPM_DEPS \
		ca-certificates \
		curl \
		xz-utils \
	--no-install-recommends && rm -r /var/lib/apt/lists/*

RUN gem install ffi
RUN gem install fpm -v 1.9.3

# Set /usr/share/oasis_error_page in a data volume
VOLUME /usr/share/oasis_error_page
