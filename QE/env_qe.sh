#!/bin/bash

#====================================================================================
#title           :env_qe.sh
#description     :This script will set the QE environment and dependencies.
#author          :Mariana Levi
#date            :Jan. 2022
#version         :0.3    
#usage           :source env_qe.sh
#notes           :Sources QE and dependencies using GNU 10.1.0 compilers and OpenMPI 4.0.5. With support of OpenBLAS, ScalaPack, FFTW3 and LIBXC. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where you'd like to install your QE.
export SOFTWARE_DIR=$HOME/q-e
export env_script=$HOME/q-e/env_qe.sh

# Set modules:
module purge
module load discovery
module load gcc/10.1.0
module load openmpi/4.0.5-skylake-gcc10.1
module load openblas/0.3.13-gcc10.1
module load scalapack/2.1.0-openmpi4.0.5-gcc10.1

# Set dependency libraries path:
qeversion=7.0
archname=cascadelake
export mylibs=$SOFTWARE_DIR/libs-$qeversion-$archname
export PATH=$mylibs/bin:$PATH
export LIBRARY_PATH=$mylibs/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$mylibs/lib:$LD_LIBRARY_PATH
export CPATH=$mylibs/include:$CPATH
export PKG_CONFIG_PATH=$mylibs/lib/pkgconfig:$PKG_CONFIG_PATH

# Set compilation and optimization flags:
export MYCFLAGS="-O3 -w -fallow-argument-mismatch -I$mylibs/include"
export MYFCFLAGS="-O3 -w -fallow-argument-mismatch -I$mylibs/include"
export MYLDFLAGS="-L$mylibs/lib"

# Set install directory path:
export qedir=$SOFTWARE_DIR/$qeversion-$archname
export PATH=$qedir/bin:$PATH
export LIBRARY_PATH=$qedir/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$qedir/lib:$LD_LIBRARY_PATH
export CPATH=$qedir/include:$CPATH

# Additional env vars:
export ESPRESSO_ROOT=$qedir
export ESPRESSO_PSEUDO=${ESPRESSO_ROOT}/pseudo
export NETWORK_PSEUDO=http://www.quantum-espresso.org/wp-content/uploads/upf_files/
export TESTCODE_DIR=${ESPRESSO_ROOT}/test-suite/testcode
