#!/usr/bin/env bash
# For the reference: CONDA env vars: https://conda.io/docs/user-guide/tasks/build-packages/environment-variables.html

### Few more R packages that are not on yet conda
#export TAR=/bin/tar  # to avoid "/bin/gtar: not found"
# The "options(unzip = )" hack to address the install_github issue under conda https://github.com/r-lib/devtools/issues/1722
#R -e "library(devtools); options(unzip = '$(which unzip)'); devtools::install_github('Francescojm/CELLector', dependencies=FALSE)"

# Changing permissions to executables
chmod +x ${SRC_DIR}/src/pcgr/*.py
chmod +x ${SRC_DIR}/*.py
chmod +x ${SRC_DIR}/src/*.R
# Moving libraries and scripts
mkdir -p ${PREFIX}/lib/R/library/pcgrr
mkdir -p ${PREFIX}/bin
mkdir -p ${SP_DIR}
mv ${SRC_DIR}/src/pcgr/lib ${SP_DIR}/pcgr  # python modules
mv ${SRC_DIR}/src/pcgr/*.py ${SRC_DIR}/*.py ${PREFIX}/bin/  # python scripts
mv ${SRC_DIR}/src/*.R ${PREFIX}/bin/  # R scripts
# R modules:
R -e "library(devtools); devtools::install('${SRC_DIR}/src/R/pcgrr', dependencies=FALSE)"

# VCF validator
wget https://github.com/EBIvariation/vcf-validator/releases/download/v0.6/vcf_validator -O ${PREFIX}/bin/vcf_validator
chmod +x ${PREFIX}/bin/vcf_validator

# LoF VEP plugin. VEP-ensemble isntalls LoF automatically, however plugin's most recent version doesn't work with the
#  most recent perl 5.26 (see https://github.com/sigven/cpsr/issues/2), so we need to manually downgrade it.
mkdir ${PREFIX}/share/loftee
tar -xzf ${SRC_DIR}/src/loftee.tgz -C ${PREFIX}/share/loftee