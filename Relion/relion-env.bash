#!/bin/bash
export mypath=$HOME/software/relion/3.1.3
export PATH=$mypath/bin:$PATH
export LD_LIBRARY_PATH=$mypath/lib:$LD_LIBRARY_PATH
module load intel/compilers-2021.2.0 openmpi/4.1.0-amd-intel2021 intel/mkl-2021.2.0 cuda/11.3 cmake/3.18.1
