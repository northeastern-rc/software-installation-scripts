#!/bin/bash
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p short
#SBATCH --mem=10G
#SBATCH --constraint=cascadelake
#SBATCH -t 02:00:00
#SBATCH -J install_gromacs2022

source env_gromacs.bash

cd ${HOME}
GROMACS_DIR=${HOME}/gromacs-2022
#REG_TEST=${GROMACS_DIR}/regressiontests-2022
wget https://ftp.gromacs.org/gromacs/gromacs-2022.tar.gz
tar -zxvf gromacs-2022.tar.gz
cd ${GROMACS_DIR}
##wget https://ftp.gromacs.org/regressiontests/regressiontests-2022.tar.gz
##tar -zxvf regressiontests-2022.tar.gz
mkdir build
cd build/
echo "cmake..."
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DCMAKE_INSTALL_PREFIX=${GROMACS_DIR}
make clean
echo "make..."
make -j 32
echo "make check..."
make check
echo "make install..."
make install
echo "Deleting tar files..."
#rm -rf ${HOME}/gromacs-2022.tar.gz ${GROMACS_DIR}/regressiontests-2022.tar.gz
rm -rf ${HOME}/gromacs-2022.tar.gz
