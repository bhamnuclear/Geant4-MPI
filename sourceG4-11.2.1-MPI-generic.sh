#!/bin/bash

#load required modules
module purge
module load bluebear
module load bear-apps/2022b
module load foss/2022b
module load CMake/3.24.3-GCCcore-12.2.0
module load X11/20221110-GCCcore-12.2.0
module load Qt5/5.15.7-GCCcore-12.2.0
module load libGLU/9.0.2-GCCcore-12.2.0
module load libglvnd/1.6.0-GCCcore-12.2.0
module load Mesa/22.2.4-GCCcore-12.2.0
module load freetype/2.12.1-GCCcore-12.2.0
module load OpenMPI/4.1.4-GCC-12.2.0
module load GCC/12.2.0
module load Xerces-C++/3.2.4-GCCcore-12.2.0
module load motif/2.3.8-GCCcore-12.2.0


#make sure you are running the code from the directory you submitted from
_type=generic-MPI
pkgver=11.2.1
export _G4_INSTALL_PWD=/rds/projects/w/wheldonc-ambe-sims/Geant4/install/${_type}/Geant4-v${pkgver}/
export CFLAGS="-march=x86-64-v4  -Os -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection"
export CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
export LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"

#initialise ROOT
source /rds/projects/w/wheldonc-ambe-sims/Geant4/ROOT/install/root-v6.30.02/bin/thisroot.sh
#source /rds/projects/w/wheldonc-ambe-sims/Geant4/ROOT/install/root-v6.30.04/bin/thisroot.sh
#source /rds/projects/w/wheldonc-ambe-sims/Geant4/ROOT/install/root-v6.28.10/bin/thisroot.sh
#export Geant4 modules
source ${_G4_INSTALL_PWD}/bin/geant4.sh

echo "Please compile with"
echo "cmake -DCMAKE_BUILD_TYPE=Release -DGeant4_DIR=${_G4_INSTALL_PWD}/lib64 $PWD/.."
echo "make"
