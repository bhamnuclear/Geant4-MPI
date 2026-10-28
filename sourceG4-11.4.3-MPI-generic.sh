#!/bin/bash
#load required modules
module purge
module load bluebear
module load bear-apps/2024a
module load foss/2024a
module load CMake/3.31.8-GCCcore-13.3.0
module load X11/20240607-GCCcore-13.3.0
module load Qt6/6.7.2-GCCcore-13.3.0
module load libGLU/9.0.3-GCCcore-13.3.0
module load libglvnd/1.7.0-GCCcore-13.3.0
module load Mesa/24.1.3-GCCcore-13.3.0
module load freetype/2.13.2-GCCcore-13.3.0
#module load tbb/2021.13.0-GCCcore-13.3.0
module load OpenMPI/5.0.3-GCC-13.3.0
module load GCC/13.3.0
module load Xerces-C++/3.2.5-GCCcore-13.3.0
module load motif/2.3.8-GCCcore-13.3.0

#make sure you are running the code from the directory you submitted from
export SRC_PWD=/rds/projects/w/wheldonc-ambe-sims/Geant4/Simulations/AmBe-Simulation

#_type=generic-MPI
_type=generic-qt6-MPI
#_type=generic
#_type=emerald-MPI
#_type=emerald
#_type=icelake-MPI
#_type=icelake

pkgver=11.4.3
#pkgver=11.3.1
#pkgver=11.3.0
#pkgver=11.2.1
#pkgver=11.1.0

export _G4_INSTALL_PWD=/rds/projects/w/wheldonc-ambe-sims/Geant4/install/${_type}/Geant4-v${pkgver}/
export CFLAGS="-march=x86-64-v4 -Os -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection"
export CXXFLAGS="$CFLAGS -Wp,-D_GLIBCXX_ASSERTIONS"
export LDFLAGS="-Wl,-O1,--sort-common,--as-needed,-z,relro,-z,now"

#initialise ROOT
#source /rds/projects/w/wheldonc-ambe-sims/Geant4/ROOT/install/root-v6.30.04/bin/thisroot.sh
source /rds/projects/w/wheldonc-ambe-sims/Geant4/ROOT/install/root-v6.30.02/bin/thisroot.sh
#source /rds/projects/w/wheldonc-ambe-sims/Geant4/ROOT/install/root-v6.28.10/bin/thisroot.sh

#export Geant4 modules
source ${_G4_INSTALL_PWD}/bin/geant4.sh

echo "Please compile with"
echo "cmake -DCMAKE_BUILD_TYPE=Release -DGeant4_DIR=${_G4_INSTALL_PWD}/lib64 $PWD/.."
echo "make"
