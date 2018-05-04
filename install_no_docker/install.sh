#!/usr/bin/env bash
# Install all PCGR dependencies to avoid using the Docker image.
# Suitable for HPC systems lacking Docker, and for debugging.
# Works only for Linux due to unavaliability of few packages for MacOS (ensembl-vep -> perl-bio-db-hts)

THIS_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Install conda if needed:
if [ ! -x "$(command -v conda)" ]; then
    echo "conda executble not in PATH; install conda under ${THIS_DIR}/miniconda"
    wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ${THIS_DIR}/miniconda.sh
    bash ${THIS_DIR}/miniconda.sh -b -p ${THIS_DIR}/miniconda
    export PATH=${THIS_DIR}/miniconda/bin:$PATH
fi

if [ -z ${CONDA_DEFAULT_ENV} ]
then
    echo "Creating new environment 'pcgr'"
    conda env create -n pcgr --file ${THIS_DIR}/conda_environment.yml
    source activate pcgr
else
    echo "Installing into existing environemnt ${CONDA_DEFAULT_ENV}"
    conda env update -n ${CONDA_DEFAULT_ENV} --file ${THIS_DIR}/conda_environment.yml
fi

SRC_DIR=${THIS_DIR}/../src

# Few more R packages that are not on yet conda (TODO: add them).
# The "options(unzip = )" hack to address the install_github issue under conda https://github.com/r-lib/devtools/issues/1722
R -e "library(devtools); options(unzip = '$(which unzip)'); devtools::install_github('mjkallen/rlogging')"
R -e "library(devtools); options(unzip = '$(which unzip)'); devtools::install_github('kent37/summarywidget')"
# This one is local
R -e "library(devtools); devtools::install('${SRC_DIR}/R/pcgrr')"

# Install VEP separately (doesn't work when within the envirnoment file, for some reason):
conda install -c vladsaveliev -y ensembl-vep
vep_install -a ap -g miRNA -l -n

# Install VEP separately (doesn't work when within the envirnoment file, for some reason).
# Installs plugins (--AUTO p)
vep_install --AUTO p --PLUGINS miRNA --NO_HTSLIB --NO_UPDATE

# Access to src scripts
chmod +x ${SRC_DIR}/pcgr/*.py
chmod +x ${SRC_DIR}/*.R