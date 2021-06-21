#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_dflowfm_67088

#====================================================================================
#title           :install_Delft3D-65936.sh
#description     :This script will install the parallel Delft3D + wave 65936.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch install_Delft3D-65936.sh
#notes           :Installs Delft3D after dependencies were installed (using Intel 2021 +  mpich/3.4.2-intel2021).
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export VERSION=65936-intel2021-mpich3.4.2
## Source environment:
source env_Delft3D-65936.sh

mkdir -p $SOFTWARE_DIR $SOFTWARE_DIR/src

#1. BZIP2:
cd $SOFTWARE_DIR/src
wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
tar -zxvf bzip2-1.0.8.tar.gz
cd bzip2-1.0.8
make -f Makefile-libbz2_so
make install PREFIX=$LIBSDIR
cp libbz2.so.1.0.8 $LIBSDIR/lib/libbz2.so

#2. Libsd:
cd $SOFTWARE_DIR/src
wget https://libbsd.freedesktop.org/releases/libbsd-0.10.0.tar.xz
tar -xvf libbsd-0.10.0.tar.xz
cd libbsd-0.10.0
./configure --prefix=$LIBSDIR
make -j
make install

#3. Expat:
cd $SOFTWARE_DIR/src
wget https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.bz2
tar -xvf expat-2.2.10.tar.bz2
cd expat-2.2.10
autoconf
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --with-libbsd
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#6. zlib:
cd $SOFTWARE_DIR/src
wget https://zlib.net/zlib-1.2.11.tar.gz
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR
make install

#7. hdf5:
cd $SOFTWARE_DIR/src
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.1/src/hdf5-1.10.1.tar.gz
tar -zxvf hdf5-1.10.1.tar.gz
cd hdf5-1.10.1
CC=mpicc FC=mpif90 CXX=mpicxx CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --enable-shared --enable-hl --enable-parallel --enable-fortran --prefix=$LIBSDIR --with-zlib=$LIBSDIR
make -j
make install

#8. netcdf-c:
cd $SOFTWARE_DIR/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.4.tar.gz
tar -zxvf netcdf-c-4.7.4.tar.gz
cd netcdf-c-4.7.4
CC=mpicc FC=mpif90 CXX=mpicxx CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --with-hdf5=$LIBSDIR --with-zlib=$LIBSDIR LIBS=-lhdf5 --enable-netcdf4 --disable-dap --disable-fortran-type-check --enable-large-file-tests --with-temp-large=$LIBSDIR
make -j
make install

#9. netcdf-fortran:
cd $SOFTWARE_DIR/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.5.3.tar.gz
tar -zxvf netcdf-fortran-4.5.3.tar.gz
cd netcdf-fortran-4.5.3
CC=mpicc FC=mpif90 CXX=mpicxx CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" LIBS=-lnetcdf ./configure --prefix=$LIBSDIR
make -j
make install

#10. libtool:
cd $SOFTWARE_DIR/src
wget  https://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
tar -zxvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
./configure --prefix=$LIBSDIR CC=$CC
make
make install

#11. automake-1.15:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/automake/automake-1.15.tar.gz
tar -zxvf automake-1.15.tar.gz
cd automake-1.15
./configure --prefix=$LIBSDIR CC=$CC
make
make install

## 12. Install D3D:
cd $DELFT3D_DIR
./autogen.sh --verbose >  log.autogen
cd third_party_open/kdtree2
./autogen.sh --verbose > log.autogen.third_party_open 2>&1
cd -
./autogen.sh

        export NETCDF_CFLAGS=-I$LIBSDIR/include
        export NETCDF_LIBS="-L$LIBSDIR/lib -lnetcdf -lnetcdff"

fflags="-O2 -fopenmp `nc-config --fflags` " cflags="-O2 " CPPFLAGS=' ' LDFLAGS=' ' CFLAGS=${cflags} CXXFLAGS=${cflags} FFLAGS=${fflags} FCFLAGS=${fflags} CC=icc CXX=icpc FC=ifort F77=ifort MPIF77=mpif90 MPIFC=mpif90 MPICXX=mpicxx ./configure --prefix="$(pwd)" --with-mpi > log.configure 2>&1

#fflags="-O2 -fopenmp `nc-config --fflags` " cflags="-O2 " CPPFLAGS=' ' LDFLAGS=' ' CFLAGS=${cflags} CXXFLAGS=${cflags} AM_FFLAGS=' ' FFLAGS=${fflags} AM_FCFLAGS=' ' FCFLAGS=${fflags} AM_LDFLAGS=' ' ./configure --prefix="$(pwd)" --with-mpi > log.configure 2>&1

cd /shared/centos7/delft3d/65936/utils_lgpl/esmfsm/packages/esmfsm_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3d/65936/tools_gpl/datsel/packages/datsel_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3d/65936/tools_gpl/kubint/packages/kubint_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3d/65936/tools_gpl/lint/packages/lint_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3d/65936/tools_gpl/vs/packages/vs_version_number/src
cp ../include/version_number.h.svn version_number.h

cd $DELFT3D_DIR
        cd engines_gpl/dimr/packages/dimr_lib/src/
        cp ../include/dimr_lib_version.h.svn dimr_lib_version.h
        cd -
        cd utils_lgpl/esmfsm/packages/esmfsm_version_number/src
        cp ../include/version_number.h.svn version_number.h
        cd -
        cd engines_gpl/flow2d3d/packages/flow2d3d/src
        cp ../include/flow2d3d_version.h.svn flow2d3d_version.h
        cd -
        cd tools_gpl/datsel/packages/datsel_version_number/src
        cp ../include/version_number.h.svn version_number.h
        cd -
        cd tools_gpl/kubint/packages/kubint_version_number/src
        cp ../include/version_number.h.svn version_number.h
        cd -
        cd tools_gpl/lint/packages/lint_version_number/src
        cp ../include/version_number.h.svn version_number.h
        cd -
        cd tools_gpl/mormerge/packages/mormerge_version_number/src
        cp ../include/version_number.h.svn version_number.h
        cd -
        cd tools_gpl/vs/packages/vs_version_number/src
        cp ../include/version_number.h.svn version_number.h
        cd -

cd $DELFT3D_DIR 
#CC=mpicc FC=mpif90 CXX=mpicxx make ds-install &> log.make

CC=mpicc FC=mpif90 CXX=mpicxx make -j 1
make install
make ds-install

cd $DELFT3D_DIR/bin
bash libtool_install.sh
