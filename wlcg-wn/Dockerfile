FROM centos:7
LABEL maintainer="Rene Caspart <rene.caspart@kit.edu>, Manuel Giffels <giffels@gmail.com>"

RUN yum update -y && yum clean -y all
RUN yum install -y epel-release \
                   https://linuxsoft.cern.ch/wlcg/centos7/x86_64/wlcg-repo-1.0.0-1.el7.noarch.rpm \
                   http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm
RUN yum update -y
RUN yum install -y apptainer cvmfs HEP_OSlibs wn tcsh python3 && \
    yum clean -y all

# Fix pseudoterminal in unpriv. namespace; see https://github.com/apptainer/apptainer/issues/297
RUN yum install -y glibc-grantpt-fix && \
    yum clean -y all
RUN echo "libc_grantpt_fix.so  # use pty fix glibc-grantpt-fix" >> /etc/ld.so.preload

# Fix for broken dcache-srmclient-6.2.24-1.noarch
RUN yum install -y java-11-openjdk java-11-openjdk-devel java-11-openjdk-headless && \
    yum clean -y all
RUN alternatives --set java $(find /usr/lib/jvm/java-11* -iname java -type f | head -n 1)

RUN sed -i "s%allow setuid = yes%allow setuid = no%g" /etc/apptainer/apptainer.conf
RUN sed -i "s%mount devpts = yes%mount devpts = no%g" /etc/apptainer/apptainer.conf

RUN rm -rf /etc/grid-security/certificates && ln -s /cvmfs/grid.cern.ch/etc/grid-security/certificates/ /etc/grid-security/certificates

RUN echo "export MACHINEFEATURES=/etc/machinefeatures" > /etc/profile.d/grid_env.sh
RUN echo "export VO_ATLAS_SW_DIR=/cvmfs/atlas.cern.ch/repo/sw" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_AUGER_SW_DIR=/cvmfs/auger.egi.eu" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_BELLE_SW_DIR=/cvmfs/belle.cern.ch/sl6" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch" >> /etc/profile.d/grid_env.sh
RUN echo "export VO_LHCB_SW_DIR=/cvmfs/lhcb.cern.ch" >> /etc/profile.d/grid_env.sh
RUN echo "unset HOME  # To support ATLAS submission" >> /etc/profile.d/grid_env.sh
