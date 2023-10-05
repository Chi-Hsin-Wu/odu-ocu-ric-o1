FROM nexus3.o-ran-sc.org:10002/o-ran-sc/bldr-ubuntu20-c-go:1.0.0

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ='Asia/Kolkata'

ARG RIC_HOST
ENV RIC_HOST=${RIC_HOST}

RUN apt-get update -y && \
	apt-get install -y wget \
	git \
	vim \
	sudo\
	net-tools\
	tcpdump

RUN ln -fs /usr/share/zoneinfo/$(wget -O - http://ip-api.com/line?fields=timezone) /etc/localtime
RUN apt-get install -y tzdata

RUN git clone --branch f-release https://github.com/o-ran-sc/o-du-l2 /root/o-du-l2

WORKDIR /root/o-du-l2/build/scripts/
RUN bash ./install_odu_dependency.sh
RUN bash ./add_netconf_user.sh
RUN sed -i -E 's/\-j[0-9]/\-j\`nproc\`/g' ./install_lib_O1.sh && bash ./install_lib_O1.sh -c
RUN bash ./load_yang.sh

WORKDIR /root/o-du-l2
COPY get_ric.sh /root/o-du-l2
RUN chmod +x get_ric.sh
RUN bash ./get_ric.sh


WORKDIR /root/o-du-l2/build/odu/
#RUN make odu MACHINE=BIT64 MODE=FDD O1_ENABLE=YES
RUN make odu MACHINE=BIT64 MODE=FDD 
RUN make cu_stub NODE=TEST_STUB MACHINE=BIT64 MODE=FDD 
#RUN make ric_stub NODE=TEST_STUB MACHINE=BIT64 MODE=FDD O1_ENABLE=YES

WORKDIR /root/o-du-l2/bin/odu/
RUN cp -r /root/o-du-l2/build/config/ .

WORKDIR /root
