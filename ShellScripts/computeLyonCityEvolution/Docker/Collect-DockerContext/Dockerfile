FROM ubuntu:18.04
LABEL vendor="UD-SV project"

# Core dependencies
# rm, mkdir, mv
RUN apt-get update
RUN apt-get -y install sed
RUN apt-get -y install wget
RUN apt-get -y install unzip

COPY ./collect_data.sh /
RUN chmod a+x /collect_data.sh
ENTRYPOINT ["/collect_data.sh"]
#CMD []
