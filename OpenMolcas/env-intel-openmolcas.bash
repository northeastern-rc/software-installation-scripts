## This script sets the software environment for OpenMolcas, installed with Intel 2021 compilers.

## Modify the following if you'd like to install the package in a different location:
export SOFTWARE_DIR=$HOME/OpenMolcas-intel

## Set the Intel compilers and libraries:
module load intel/compilers-2021.3.0 
module load intel/mkl-2021.3.0 
module load intel/mpi-2021.3.0
module load intel/python-daal4py-2021.3.0
source /shared/centos7/intel/oneapi/2021.3.0/setvars.sh

export CC=icc
export CXX=icpc
export CFLAGS='-O2 -fpic'
export CXXFLAGS='-O2 -fpic'
export CPPFLAGS='-O2 -fpic'
export F77=ifort
export FC=ifort
export F90=ifort
export FFLAGS='-O2 -fpic'
export CPP='icpc -E'
export CXXCPP='icpc -E'


#2. Set the GA paths:
export PATH=$SOFTWARE_DIR/ga/bin:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_DIR/ga/lib:$LD_LIBRARY_PATH
export CPATH=$SOFTWARE_DIR/ga/include:$CPATH
export GAROOT=$SOFTWARE_DIR/ga
export GA=$SOFTWARE_DIR/ga

#3. Set the OpenMolcas paths:
export PATH=$SOFTWARE_DIR/latest-intel/bin:$SOFTWARE_DIR/latest-intel/sbin:$SOFTWARE_DIR/OpenMolcas/sbin:$SOFTWARE_DIR/OpenMolcas/Tools/pymolcas:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_DIR/latest-intel/lib:$LD_LIBRARY_PATH
export MOLCAS=$SOFTWARE_DIR/latest-intel

export PYTHON=/shared/centos7/intel/oneapi/2021.3.0/intelpython/python3.7/bin/python
