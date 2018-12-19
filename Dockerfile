# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Install OpenJDK and SBT
RUN echo "deb https://dl.bintray.com/sbt/debian /" >> /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
      sbt=1.2.7 \
      openjdk-8-jdk-headless=8u191-b12-0ubuntu0.18.04.1 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*

WORKDIR /code

RUN sbt compile

# Clean up APT when done.
RUN rm -rf /tmp/* /var/tmp/*

CMD ["sbt"]
