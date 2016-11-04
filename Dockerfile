FROM java:8

MAINTAINER zoido <zoido@users.noreply.github.com>

ENV ANT_VERSION 1.9.7
ENV PHANTOMBOT_VERSION v2.3.2

##############################################################################
# závislosti
RUN apt-get -y update && apt-get -y install git

# Install Apache Ant for the build
WORKDIR /tmp/ant

RUN wget -q http://www.eu.apache.org/dist/ant/binaries/apache-ant-${ANT_VERSION}-bin.tar.gz \
    && tar xzf apache-ant-${ANT_VERSION}-bin.tar.gz \
    && mv apache-ant-${ANT_VERSION} /opt/ant \
    && rm -f apache-ant-${ANT_VERSION}-bin.tar.gz

ENV ANT_HOME /opt/ant
ENV PATH ${PATH}:/opt/ant/bin

##############################################################################
# Build

WORKDIR /tmp
RUN git clone https://github.com/PhantomBot/PhantomBot.git \
    && cd PhantomBot \
    && git checkout ${PHANTOMBOT_VERSION} \
    && ant

# Copy
RUN mkdir /opt/phantombot \
    && cp -r PhantomBot/dist/build/* /opt/phantombot

# cleanup
RUN rm -rf /tmp/*\
     && rm -rf /opt/ant\
     && rm -rf /usr/src/

WORKDIR /opt/phantombot
RUN chmod u+x launch.sh && chmod u+x launch-service.sh


RUN mkdir /var/phantomfs
RUN touch phantombot.db
VOLUME ["/opt/phantombot/logs", "/opt/phantombot/scripts/lang/custom"]


# 25000 - baseport
# 25005 - webserver
# 25004 - websocket
EXPOSE 25005 25004

CMD ["./launch-service.sh"]

