FROM ubuntu:20.04

# init
RUN apt-get update && apt-get -y upgrade

# time zone
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Ipopt
RUN apt-get install -y gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev locales build-essential
RUN locale-gen "en_US.UTF-8"

# Python3
RUN apt-get install -y apt-utils
RUN apt-get install -y python3.8 python3-pip
RUN ln -s /usr/bin/pip3 /usr/bin/pip
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip install pyomo

# coinbrew
WORKDIR /tmp
RUN wget https://raw.githubusercontent.com/coin-or/coinbrew/master/coinbrew
RUN chmod u+x coinbrew
RUN ./coinbrew fetch Ipopt --no-prompt

# HSL
COPY data/coinhsl-2015.06.23.tar.gz .
RUN tar -xvzf coinhsl-2015.06.23.tar.gz
RUN mv coinhsl-2015.06.23 ThirdParty/HSL/coinhsl

# buil IPOPT
RUN ./coinbrew build Ipopt --prefix=build --test --no-prompt --verbosity=3
ENV LD_LIBRARY_PATH=/tmp/build/lib
