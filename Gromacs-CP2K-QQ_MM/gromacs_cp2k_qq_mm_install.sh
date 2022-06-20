#!/bin/bash

#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=24
#SBATCH --partition=short
#SBATCH --time=02:00:00
#SBATCH -J install_gromacs_cp2k
#SBATCH --constraint=cascadelake


## Install cp2k V9.1.0 

module purge
module load discovery
module load gcc/11.1.0
module load openmpi/4.1.2-gcc11.1
module load cmake/3.18.1
module load python/3.8.1

SOFTWARE_DIR=${HOME}/gromacs-cp2k
CP2K_DIR=${SOFTWARE_DIR}/cp2k
CP2K_TOOL_DIR=${CP2K_DIR}/tools/toolchain
GROMACS_DIR=${SOFTWARE_DIR}/gromacs-2022

mkdir -p ${SOFTWARE_DIR}

cd ${SOFTWARE_DIR}

git clone -b support/v9.1 https://github.com/cp2k/cp2k.git cp2k

cd ${CP2K_DIR}

git submodule update --init --recursive

cd ${CP2K_TOOL_DIR}

./install_cp2k_toolchain.sh -j 24 --no-check-certificate \
	--install-all \
	--with-gcc=system \
	--with-cmake=system \
	--with-openmpi=system \
	--with-libsmm=install \
	--with-libxsmm=no \
	--with-spla=no \
	--with-pexsi=no \
	--with-plumed=no \
	--with-sirius=no

cp ${CP2K_TOOL_DIR}/install/arch/* ${CP2K_DIR}/arch/

source ${CP2K_TOOL_DIR}/install/setup

cd ${CP2K_DIR}

make -j 24 ARCH=local VERSION=psmp libcp2k


## Install Gromacs 2022

cd ${SOFTWARE_DIR}

wget https://ftp.gromacs.org/gromacs/gromacs-2022.tar.gz

tar -zxf gromacs-2022.tar.gz

cd ${GROMACS_DIR}

mkdir build

cd build

## Configure ##
cmake .. -DREGRESSIONTEST_DOWNLOAD=ON \
	-DCMAKE_C_COMPILER=mpicc \
	-DCMAKE_CXX_COMPILER=mpicxx \
	-DGMX_MPI=ON \
	-DBUILD_SHARED_LIBS=OFF \
	-DGMXAPI=OFF \
	-DGMX_INSTALL_NBLIB_API=OFF \
	-DGMX_DOUBLE=ON \
	-DGMX_CP2K=ON \
	-DCP2K_DIR=${CP2K_DIR}/lib/local/psmp \
	-DGMX_DEFAULT_SUFFIX=OFF \
	-DGMX_BINARY_SUFFIX=_cp2k \
	-DGMX_LIBS_SUFFIX=_cp2k \
	-DCMAKE_INSTALL_PREFIX=${SOFTWARE_DIR}/gromacs-double_precision

make clean

## Build ##
make -j 24

## Install to path ${GROMACS_DIR}/bin ##
make install

rm ${SOFTWARE_DIR}/gromacs-2022.tar.gz

