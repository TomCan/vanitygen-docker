FROM alpine

RUN apk add --no-cache --virtual build-dependencies
RUN apk add --update make git g++ openssl-dev
RUN apk add pcre pcre-dev opencl-headers opencl-icd-loader-dev opencl-icd-loader
RUN apk add curl curl-dev

RUN cd / \
	&& git clone https://github.com/exploitagency/vanitygen-plus.git \
	&& cd vanitygen-plus \
	&& cat Makefile \
	&& make all \
	&& cp vanitygen /usr/bin/ \ 
	&& cp oclvanitygen /usr/bin/ \ 
	&& cp keyconv /usr/bin/

RUN apk del build-dependencies g++ && rm -rf /var/cache/apk/*

COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]

