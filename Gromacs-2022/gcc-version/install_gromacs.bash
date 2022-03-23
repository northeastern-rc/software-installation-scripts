#!/bin/bash
set -e
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p short
#SBATCH --mem=10G
#SBATCH --constraint=cascadelake
#SBATCH -t 02:00:00
#SBATCH -J install_gromacs2022

source "$( dirname $0 )/env_gromacs.bash"

cd ${INSTALL_DIR}
## Download Gromacs-2022 software source code ##
wget https://ftp.gromacs.org/gromacs/gromacs-2022.tar.gz
tar -zxvf gromacs-2022.tar.gz
cd ${GROMACS_DIR}

mkdir build
cd build/

## Configure ##
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DCMAKE_INSTALL_PREFIX=${GROMACS_DIR}
make clean

## Build ##
make -j 32

## Verify the build ##
make check

## Install to path ${GROMACS_DIR}/bin ##
make install

## Delete tar file ##
rm -f ${INSTALL_DIR}/gromacs-2022.tar.gz
