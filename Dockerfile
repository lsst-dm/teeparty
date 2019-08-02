FROM continuumio/miniconda:latest

WORKDIR /workspace
ADD environment.lock.yml .
RUN conda-env create -n default.lock -f /workspace/environment.lock.yml
