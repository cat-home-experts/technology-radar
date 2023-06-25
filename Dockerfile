FROM wwwthoughtworks/build-your-own-radar:latest

ARG VERSION

ADD versions /opt/build-your-own-radar/files/versions
RUN ln -s /opt/build-your-own-radar/files/versions/${VERSION}.json /opt/build-your-own-radar/files/latest.json