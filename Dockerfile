# Use a slimmed down image that has better 
FROM phusion/baseimage:0.11

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

RUN  apt-get update \
  && apt-get install -y openjdk-8-jdk-headless

RUN echo "deb https://dl.bintray.com/sbt/debian /" >> /etc/apt/sources.list.d/sbt.list \
  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt-get update \
  && apt-get install -y sbt

COPY . /base-lib
WORKDIR /base-lib
RUN sbt compile

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["sbt"]

# Expose code volume and play port 9000 and secure port 9443
EXPOSE 9000
EXPOSE 9443
VOLUME "/code"
WORKDIR /code
