FROM	ubuntu:16.04

ARG	http_proxy
ARG	https_proxy

RUN	apt-get update && \
	apt-get install -y \
	build-essential \
	git \
	g++ \
	libgtk-3-dev \
	gtk-doc-tools \
	gnutls-bin \
	valac \
	intltool \
	libpcre2-dev \
	libglib3.0-cil-dev \
	libgnutls28-dev \
	libgirepository1.0-dev \
	libxml2-utils \
	gperf

RUN	git clone https://github.com/thestinger/termite.git && \
	rm -rf termite/util && \
	git clone https://github.com/thestinger/util.git termite/util
RUN	git clone https://github.com/thestinger/vte-ng.git

#export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
RUN	cd vte-ng && ./autogen.sh && make && make install
RUN	cd ../termite && make

VOLUME	/target
ENTRYPOINT ["cp", "termite/termite", "termite/termite.desktop", "termite/termite.terminfo", "/target/"]

## to get termite, you can build and run this container:
# docker build -t termite-install .
# docker run --rm -it -v $(pwd):/target termite-install

