FROM registry.access.redhat.com/ubi8/ubi-init:latest
ADD etc/systemd/system/* /etc/systemd/system/
RUN systemctl enable test.service
RUN useradd test
RUN mkdir /var/lib/test && chown test:root /var/lib/test
ADD --chown=test:root var/lib/test/test.sh /var/lib/test/

RUN dnf -y install httpd && \
    dnf clean all && \
    # Tell systemd to start httpd
    systemctl enable httpd