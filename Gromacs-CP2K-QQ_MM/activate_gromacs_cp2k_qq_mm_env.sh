#!/bin/bash

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


source ${CP2K_TOOL_DIR}/install/setup
source ${SOFTWARE_DIR}/gromacs-double_precision/bin/GMXRC
export PATH=${SOFTWARE_DIR}/gromacs-double_precision/bin:$PATH
export LD_LIBRARY_PATH=${SOFTWARE_DIR}/gromacs-double_precision/lib64:$LD_LIBRARY_PATH


