#!/bin/bash

#=====================================================================================
# This script will create and activate a conda environment, and then install 
# required packages
# 
# Prior to running this, please ensure you have miniconda installed on your $HOME
# using the instructions here:
# https://rc-docs.northeastern.edu/en/latest/software/conda.html
#
# Please ensure to run this script as an interactive job on a compute node.
# You can request an interactive job as below:
# srun --partition=short --nodes=1 --ntasks=1 --mem=5G --time=01:00:00 --pty /bin/bash
# You can find additional instructions here:
# https://rc-docs.northeastern.edu/en/latest/using-discovery/srun.html
#
# Author: Shobana Sekar, Research Computing, ITS, Northeastern University
# Date: 16 July, 2021
#=====================================================================================


# Create a conda environment for your required packages
conda create -y -n Matlab_test_env

# Activate the enviroment
source ~/miniconda3/bin/activate Matlab_test_env 

# Install the required packages
conda install -y -c anaconda gstreamer
conda install -y -c conda-forge gst-plugins-ugly
conda install -y -c conda-forge gst-plugins-base
conda install -y -c conda-forge gst-plugins-good
conda install -y -c conda-forge gst-libav
conda install -y -c conda-forge gst-plugins-bad
conda install -y -c yaafe libmpg123
