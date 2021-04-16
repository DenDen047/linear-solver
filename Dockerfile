FROM ubuntu:20.04

# init
RUN apt-get update && apt-get -y upgrade

# Ipopt
RUN apt-get install -y gcc g++ gfortran git patch wget pkg-config liblapack-dev libmetis-dev
WORKDIR /tmp/hsl_solver

RUN wget https://raw.githubusercontent.com/coin-or/coinbrew/master/coinbrew
RUN chmod +x coinbrew
RUN ./coinbrew fetch Ipopt --no-prompt

RUN ls -al
