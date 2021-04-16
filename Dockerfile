FROM ubuntu:20.04

# init
RUN apt-get update && apt-get -y upgrade

# time zone
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Ipopt
RUN apt-get install -y gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev

WORKDIR /tmp/hsl_solver
RUN wget https://raw.githubusercontent.com/coin-or/coinbrew/master/coinbrew
RUN chmod +x coinbrew
RUN ./coinbrew fetch Ipopt --no-prompt
# =========
RUN tar -xvzf coinhsl-2015.06.23.tar.gz
RUN mv coinhsl-2015.06.23 ThirdParty/HSL/coinhsl

RUN ./coinbrew build Ipopt --prefix=build --test --no-prompt --verbosity=3
