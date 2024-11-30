
ARG BASE_IMAGE=ghcr.io/felddy/weewx:release-5.0.2
FROM ${BASE_IMAGE}

RUN apt-get update && apt-get install rtl-sdr rtl-433 wget -y
RUN chmod u+s /usr/bin/rtl_433


