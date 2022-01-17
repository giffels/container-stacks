#!/bin/bash
# --nv flag does not work in nested singularity containers
# this workaround ensures that --nv even works in nested singularity containers
# details can be found in https://github.com/apptainer/singularity/issues/5759 

TMPD=$(mktemp -d)

cat << EOF > ${TMPD}/ldconfig
#!/bin/bash
exec /usr/sbin/ldconfig -C ${TMPD}/ld.so.cache \$@ > ${TMPD}/ldconfig
EOF

chmod +x ${TMPD}/ldconfig

PATH=${TMPD}:${PATH}
ldconfig ${LD_LIBRARY_PATH}

