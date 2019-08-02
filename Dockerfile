FROM continuumio/miniconda:latest

WORKDIR /workspace
ADD environment.lock.yml .
RUN conda-env create -n default.lock -f /workspace/environment.lock.yml

# Install eups
RUN conda run -n default.lock /bin/bash -c '\
    curl -OL https://github.com/RobertLuptonTheGood/eups/archive/2.1.5.tar.gz; \
    tar xzf 2.1.5.tar.gz; \
    cd eups-2.1.5; \
    ./configure \
        --prefix="${CONDA_PREFIX}/opt/eups" \
        --with-python="${CONDA_PREFIX}/bin/python" \
        --with-eups="${CONDA_PREFIX}/share/eups"; \
    make; \
    make install; \
    cd -; \
    rm 2.1.5.tar.gz; \
    rm -rf eups-2.1.5; \
    source ${CONDA_PREFIX}/opt/eups/bin/setups.sh; \
'

RUN conda run -n default.lock pip install git+https://github.com/lsst/lsst_build
RUN conda run -n default.lock /bin/bash -c '\
    curl -L "https://raw.githubusercontent.com/lsst/repos/master/etc/repos.yaml" >> ${CONDA_PREFIX}/etc/repos.yaml; \
'

# In the container, you can do your business
# conda activate default.lock
# source ${CONDA_PREFIX}/opt/eups/bin/setups.sh
# export REF=u/bvan/teeparty
# lsst-build prepare --repos ${CONDA_PREFIX}/etc/repos.yaml --ref ${REF} . sconsUtils
# lsst-build build .

