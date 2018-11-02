#!/usr/bin/env bash

### Few more R packages that are not on yet conda
export TAR=/bin/tar  # to avoid "/bin/gtar: not found"
# The "options(unzip = )" hack to address the install_github issue under conda https://github.com/r-lib/devtools/issues/1722
R -e "library(devtools); options(unzip = '$(which unzip)'); devtools::install_github('mjkallen/rlogging')"
#R -e "library(devtools); options(unzip = '$(which unzip)'); devtools::install_github('Francescojm/CELLector', dependencies=FALSE)"

# CONDA env vars: https://conda.io/docs/user-guide/tasks/build-packages/environment-variables.html
mv ${SRC_DIR}/pcgr/lib ${SP_DIR}/pcgr  # python modules
mv ${SRC_DIR}/pcgr/*.py ${PREFIX}/bin  # python scripts

mkdir -p $PREFIX/lib/R/library/pcgrr && mv ${SRC_DIR}/R/pcgrr/* $PREFIX/lib/R/library/pcgrr  # R modules
mv ${SRC_DIR}/R/*.R ${PREFIX}/bin  # R scripts

wget https://github.com/EBIvariation/vcf-validator/releases/download/v0.6/vcf_validator -O ${CONDA_PREFIX}/bin/vcf_validator
chmod +x ${CONDA_PREFIX}/bin/vcf_validator
