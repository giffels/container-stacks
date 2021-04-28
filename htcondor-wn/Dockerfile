FROM centos:7
MAINTAINER Manuel Giffels <giffels@gmail.com>

RUN rpm --import http://research.cs.wisc.edu/htcondor/yum/RPM-GPG-KEY-HTCondor
RUN yum install -y https://research.cs.wisc.edu/htcondor/repo/9.0/htcondor-release-current.el7.noarch.rpm

RUN yum -y install epel-release && yum clean all
RUN yum -y install condor \
                   python36 \
                   ansible \
                   git \
                   singularity \
                   tsocks \
     && yum clean all

RUN python3.6 -m pip install --no-cache-dir condor_git_config pexpect

# Add ansible community collection
RUN ansible-galaxy collection install community.general -p /usr/share/ansible/collections

# Add Tini
ENV TINI_VERSION v0.19.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

COPY ansible_config /srv/ansible_config
COPY pilot_execute.sh /srv/pilot_execute.sh
RUN chmod +x /srv/pilot_execute.sh

WORKDIR /srv
ENTRYPOINT ["/tini", "-s", "--", "/srv/pilot_execute.sh"]
