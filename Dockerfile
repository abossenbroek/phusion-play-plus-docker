# Use phusion/baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
# See https://github.com/phusion/baseimage-docker/blob/master/Changelog.md for
# a list of version numbers.
FROM phusion/baseimage:0.11

ARG APPLICATION_SECRET

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# See https://askubuntu.com/questions/190582/installing-java-automatically-with-silent-option
RUN echo debconf shared/accepted-oracle-license-v1-1 select true | \
  debconf-set-selections && \
  echo debconf shared/accepted-oracle-license-v1-1 seen true | \
  debconf-set-selections

# Install Orace JDK and not SBT (commands for SBT are outcommented)
RUN add-apt-repository ppa:webupd8team/java \
#  && echo "deb https://dl.bintray.com/sbt/debian /" >> /etc/apt/sources.list.d/sbt.list \
#  && apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 2EE0EA64E40A89B84B2DF73499E82A75642AC823 \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
      oracle-java8-installer=8u191-1~webupd8~1 \
      oracle-java8-set-default=8u191-1~webupd8~1 \
#      sbt=1.2.7 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Taken from cats options: https://github.com/typelevel/cats/blob/master/.jvmopts
RUN echo "-J-Xms1G" >> /etc/sbt/sbtopts \
  && echo "-J-Xmx3G" >> /etc/sbt/sbtopts \
  && echo "-J-XX:ReservedCodeCacheSize=250M" >> /etc/sbt/sbtopts \
  && echo "-J-XX:+TieredCompilation" >> /etc/sbt/sbtopts \
  && echo "-J-XX:-UseGCOverheadLimit" >> /etc/sbt/sbtopts \
  && echo "-J-XX:+CMSClassUnloadingEnabled" >> /etc/sbt/sbtopts \
  && echo "-J-XX:+UseConcMarkSweepGC " >>  /etc/sbt/sbtopts

