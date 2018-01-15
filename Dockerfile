FROM centos:latest
MAINTAINER freedoms1988 zzt328697768@gmail.com
USER root
RUN yum update
RUN yum install -y vim
RUN yum install -y wget
RUN yum install -y openssh-server
RUN yum install -y openssh-clients
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
RUN sed '/^#Host_Key/'d /etc/ssh/sshd_config
RUN sed '/^Host_Key/'d /etc/ssh/sshd_config
RUN echo 'HostKey /etc/ssh/ssh_host_rsa_key'>/etc/ssh/sshd_config
RUN ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key
RUN mkdir -p /root/.ssh
RUN echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDNYXyDd8RLahbcgW7uLzoJgg9LHxNbl9EO82jdCh2VTOKl4ky/oK94wNeifdX8dpty9yjvV/47JU84CQWxUPm5d4xuV9zraq0G0COOMFZ0bNPQHYKaJGyDIVKbi0eWXBRxy+Doq7GCYAP1zKJSpsmHKkInJ0JOvzzcxbAFmzfgTV+2AKTv8W6o8fKFr8uA81XHbHSnUCHiiZbbQxpMaBlOPufZI1RB0E9TflGsBmjuLmVUhoDHKessZ65Mk47SSLL6B23hRWNgLdfkS6N2zAKpBUBubO4MUYwhmWLRzrvMjI7PtuhypoyKCGvd53gOzeRbtsq+q7PaGVpoRa4I0xlF freedoms@Freedoms.local'>/root/.ssh/authorized_keys
RUN echo 'root:zzt2046zzt'|chpasswd
RUN systemctl enable sshd.service
EXPOSE 22
CMD ["/usr/sbin/sshd start"]