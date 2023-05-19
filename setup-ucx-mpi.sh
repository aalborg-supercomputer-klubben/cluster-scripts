#!/bin/bash -e

if [ "$EUID" -ne 0 ]; then 
  echo "please run as root"
  exit
fi

export INSTALL_DIR="/opt/top500/mpi"
export UCX_DIR="$INSTALL_DIR/ucx-build"
export UCX_BUILD_DIR="$INSTALL_DIR/ucx-install"
export MPI_DIR="$INSTALL_DIR/mpi-ucx-build"
export MPI_BUILD_DIR="$INSTALL_DIR/mpi-ucx-install"

echo $INSTALL_DIR
echo $UCX_DIR
echo $UCX_BUILD_DIR
echo $MPI_DIR
echo $MPI_BUILD_DIR



if ! [[ -e $UCX_DIR ]]; then
  printf "\nucx not found, installing ucx\n"
  git clone https://github.com/openucx/ucx.git -b v1.15.x $UCX_DIR
  cd $UCX_DIR
  if ! [[ -e /usr/bin/autoconf ]]; then
    apt-get install autoconf
  fi
  if ! [[ -e /usr/bin/libtool ]]; then
    apt-get install libtool
  fi
  ./autogen.sh
  mkdir build
  cd build
  ../contrib/configure-release --prefix=$UCX_BUILD_DIR \
    --without-cuda \
    --enable-optimizations --disable-logging \
    --disable-assertions \
    --without-java
#    --with-xpmem=$XPMEM_DIR \
  make -j$(nproc)
  make -j$(nproc) install
else
  printf "\nucx already installed\n"
fi
export OMPI_DIR=$MPI_DIR
if ! [[ -e $OMPI_DIR ]]; then
  printf "\nopen-mpi not found, installing open-mpi\n"
  git clone --recursive https://github.com/open-mpi/ompi.git -b v5.0.x $OMPI_DIR
  cd $OMPI_DIR
  ./autogen.pl
  mkdir build
  cd build
  ../configure --prefix=$MPI_BUILD_DIR --with-ucx=$UCX_BUILD_DIR \
    --enable-mca-no-build=btl-uct --enable-mpi1-compatibility \
    CC=gcc CXX=g++ FC=gfortran
  make -j 
  make -j install
else
  printf "\ngcc open-mpi already installed\n"
fi

