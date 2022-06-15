#!/bin/bash

#=====================================================================================
# This script will set up the environment required to run Matlab. 
# Please ensure to run this after running gstreamer_setup_step1.sh
#
# You will need to run this script everytime you want to run Matlab with gstreamer,
# but you will only need to run gstreamer_setup_step1.sh the first time you are
# setting up your conda environment.
#
# Author: Shobana Sekar, Research Computing, ITS, Northeastern University
# Date: 16 July, 2021
#=====================================================================================

module load matlab/R2020b
source ~/miniconda3/bin/activate Matlab_test_env
export LD_LIBRARY_PATH=~/miniconda3/envs/Matlab_test_env/lib:$LD_LIBRARY_PATH
