#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_wrf_wps

#====================================================================================
#title           :install_wrf_wps.sh
#description     :This script will install the parallel WRF/WPS versions 4.1.4/4.1.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch install_wrf_wps.sh
#notes           :Installs WRF/WPS after dependencies were installed (using Intel 2021): zlib, libpng, jpg, szip, JASPER, hdf5-parallel, netcdf-c & netcdf-fortran.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

## Source the environment shell script:
source $SOFTWARE_DIR/setenv_wrf_wps.sh

## Create the src directory:
mkdir -p $SOFTWARE_DIR/src

## Create the library directory:
mkdir -p $diretorio 

# 1. Build zlib:
cd $SOFTWARE_DIR/src
wget http://zlib.net/fossils/zlib-1.2.11.tar.gz
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
./configure --prefix=$diretorio
make
make install

# 2. Build libpng:
cd $SOFTWARE_DIR/src
wget https://github.com/glennrp/libpng/archive/v1.6.37.tar.gz
tar -zxvf v1.6.37.tar.gz
cd libpng-1.6.37
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$diretorio/include" LDFLAGS="-L$diretorio/lib" ./configure --prefix=$diretorio
make 
make install

# 3. Build jpg:
cd $SOFTWARE_DIR/src
wget https://fossies.org/linux/misc/jpegsrc.v9b.tar.gz
tar -zxvf jpegsrc.v9b.tar.gz
cd jpeg-9b
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$diretorio/include" LDFLAGS="-L$diretorio/lib" ./configure --prefix=$diretorio
make
make install

# 4. Build szip:
cd $SOFTWARE_DIR/src
wget https://support.hdfgroup.org/ftp/lib-external/szip/2.1.1/src/szip-2.1.1.tar.gz
tar -zxvf szip-2.1.1.tar.gz
cd szip-2.1.1
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$diretorio/include" LDFLAGS="-L$diretorio/lib" ./configure --prefix=$diretorio
make
make install

# 5. Build JASPER:
cd $SOFTWARE_DIR/src
wget https://github.com/mdadams/jasper/archive/version-2.0.16.tar.gz
tar -zxvf version-2.0.16.tar.gz
cd jasper-version-2.0.16
module load cmake/3.18.1
cmake -G "Unix Makefiles" -H$diretorio/src/jasper-version-2.0.16 -B$diretorio/src/jasper-version-2.0.16/build -DCMAKE_INSTALL_PREFIX=$diretorio
cd $diretorio/src/jasper-version-2.0.16/build
make install

# 6. Build hdf5:
cd $SOFTWARE_DIR/src
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz
tar -zxvf hdf5-1.12.0.tar.gz
cd hdf5-1.12.0
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$diretorio/include" LDFLAGS="-L$diretorio/lib" ./configure --prefix=$diretorio --with-zlib=$diretorio --with-szip=$diretorio --enable-fortran --enable-cxx
make -j
make install

# 7. Build netcdf-c:
cd $SOFTWARE_DIR/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.4.tar.gz
tar -zxvf netcdf-c-4.7.4.tar.gz
cd netcdf-c-4.7.4
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I${diretorio}/include" LDFLAGS=-L${diretorio}/lib ./configure --prefix=$diretorio FC=ifort F77=ifort F90=ifort CC=icc CXX=icpc --with-hdf5=${diretorio} --with-szip=${diretorio} --with-zlib=${diretorio} --enable-large-file-tests --with-temp-large=${diretorio} --enable-netcdf4 --disable-dap --disable-fortran-type-check
make -j
make install

wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.5.3.tar.gz
tar -zxvf netcdf-fortran-4.5.3.tar.gz
cd netcdf-fortran-4.5.3
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I${diretorio}/include" LDFLAGS=-L${diretorio}/lib ./configure --prefix=$diretorio
make
make install

# 8. Install WRF:
cd $SOFTWARE_DIR/src
wget https://github.com/wrf-model/WRF/archive/v4.1.4.tar.gz
cd $SOFTWARE_DIR
tar -zxvf src/WRFv4.1.4.tar.gz
cd WRF-4.1.4
echo -e "15\n1\n" | ./configure | tee configure.log
# Optional - modify optimization flags in configure.wrf:
#FCOPTIM         =       -O3 -xCORE-AVX512
# change mpif90 to mpiifort and change mpicc to mpiicc:
sed "s/mpif90/mpiifort/g;s/mpicc/mpiicc/g" configure.wrf > configure.wrf.temp
mv configure.wrf.temp configure.wrf
./compile -j $SLURM_NTASKS em_real 2>&1 | tee compile_wrf.log

# 9. Install WPS:
cd $SOFTWARE_DIR/src
wget https://github.com/wrf-model/WPS/archive/refs/tags/v4.1.tar.gz
cd $SOFTWARE_DIR
tar -zxvf src/WPS4.1.tar.gz
cd WPS-4.1
#Modify lines in configure.wps:
#COMPRESSION_LIBS = -L$(diretorio)/lib64 -ljasper -L$(diretorio)/lib -lpng -lz
#COMPRESSION_INC = -I$(diretorio)/include
#change mpif90 to mpiifort and change mpicc to mpiicc:
sed "s/mpif90/mpiifort/g;s/mpicc/mpiicc/g" configure.wps > configure.wps.temp
mv configure.wps.temp configure.wps
./compile 2>&1 | tee compile_wps.log
