FROM centos:7
MAINTAINER Rene Caspart <rene.caspart@kit.edu>

RUN yum update -y && yum clean -y all
RUN yum install -y epel-release \
                   https://linuxsoft.cern.ch/wlcg/centos7/x86_64/wlcg-repo-1.0.0-1.el7.noarch.rpm \
                   http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm
RUN yum update -y
RUN yum install -y singularity cvmfs HEP_OSlibs wn tcsh && \
    yum clean -y all

RUN sed -i "s%allow setuid = yes%allow setuid = no%g" /etc/singularity/singularity.conf
RUN sed -i "s%mount devpts = yes%mount devpts = no%g" /etc/singularity/singularity.conf

RUN rm -rf /etc/grid-security/certificates && ln -s /cvmfs/grid.cern.ch/etc/grid-security/certificates/ /etc/grid-security/certificates

RUN echo "export MACHINEFEATURES=/etc/machinefeatures" > /etc/profile.d/machinefeatures.sh
