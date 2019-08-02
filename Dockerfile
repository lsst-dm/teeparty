FROM continuumio/miniconda:latest

WORKDIR /workspace
ADD environment.lock.yml .
RUN conda-env create -n default.lock -f /workspace/environment.lock.yml
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
'
