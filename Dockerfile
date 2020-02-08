FROM debian:stable-slim

RUN apt-get update
RUN apt-get install -y git make curl make gcc g++
RUN apt-get install -y build-essential libtool autotools-dev automake pkg-config bsdmainutils python3
RUN apt-get install -y libevent-dev libboost-system-dev libboost-filesystem-dev libboost-chrono-dev libboost-test-dev libboost-thread-dev


RUN git clone https://github.com/dspicher/bitcoin.git

WORKDIR /bitcoin
RUN git checkout rbf-analysis
RUN ./autogen.sh
RUN ./configure --disable-wallet --without-gui --without-miniupnpc --disable-tests 
RUN make
RUN make install

WORKDIR /
RUN mkdir .bitcoin
COPY bitcoin.conf /.bitcoin/
ENTRYPOINT ["bitcoind"]
