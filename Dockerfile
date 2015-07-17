FROM collokia/ubuntu-with-dev-utils

EXPOSE 8085
VOLUME "/bamboo/home"

ENV BAMBOO_HOME /bamboo/home
ENV BAMBOO_VERSION 5.9.2

RUN mkdir -p /tmp/build \
	/bamboo/installed \
    "$BAMBOO_HOME"

RUN wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-${BAMBOO_VERSION}.tar.gz -O /tmp/build/bamboo.tgz && tar -xzf /tmp/build/bamboo.tgz -C /bamboo/installed \
    && ln -s /bamboo/installed/atlassian-bamboo-${BAMBOO_VERSION} /bamboo/current

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR  /bamboo/current
ENTRYPOINT ["bash", "-ex", "/bamboo/current/bin/start-bamboo.sh", "-fg"]
