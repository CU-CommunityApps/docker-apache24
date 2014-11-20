FROM docker.cucloud.net/base

# Install.
RUN \
  apt-get update && \
  apt-get install -y apache2 && \
  apt-get clean

RUN \ 
  a2enmod ssl \
  proxy \
  proxy_http 

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]