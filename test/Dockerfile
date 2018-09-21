FROM debian
COPY install.tar.gz /opt
RUN apt update \ 
  && cd /opt \
  && tar -xzvf install.tar.gz \
  && rm /opt/install/var
COPY var /opt/install/var
RUN cd /opt/install \
  && ./install.sh
