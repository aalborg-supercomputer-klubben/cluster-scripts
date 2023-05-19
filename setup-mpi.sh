#!/bin/sh

set -o xtrace
set -e

OPENMPI_VERSION="4.1.5"
OPENMPI_NAME="openmpi-${OPENMPI_VERSION}"
OPENMPI_ARCHIVE="${OPENMPI_NAME}.tar.bz2"

rm -rf "mpi-build" "mpi-install" || true
[ ! -f "$OPENMPI_ARCHIVE" ] && wget "https://download.open-mpi.org/release/open-mpi/v4.1/$OPENMPI_ARCHIVE"
tar -xf "$OPENMPI_ARCHIVE"

mkdir "mpi-build" "mpi-install"

cd "mpi-build"
  "../${OPENMPI_NAME}/configure" \
    --prefix "/opt/top500/mpi/mpi-install" \
    --enable-static \
    CFLAGS='-flto' \
    CXXFLAGS='-flto'
make all install
cd ..
