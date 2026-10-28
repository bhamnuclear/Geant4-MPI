#!/bin/bash
#load required modules
module purge
#module load bluebear
module load bear-apps/2021b
module load CMake/3.22.1-GCCcore-11.2.0
module load foss/2021b
module load X11/20210802-GCCcore-11.2.0
module load Qt5/5.15.2-GCCcore-11.2.0
module load libGLU/9.0.2-GCCcore-11.2.0
module load libglvnd/1.3.3-GCCcore-11.2.0
module load Mesa/21.1.7-GCCcore-11.2.0
module load freetype/2.11.0-GCCcore-11.2.0
module load GCC/11.2.0
module load Python/3.9.6-GCCcore-11.2.0
module load OpenMPI/4.1.1-GCC-11.2.0
#module load Xerces-C++/3.2.3-GCCcore-10.3.0
#module load FIX/1.06.15-foss-2021a

#make sure you are running the code from the directory you submitted from
_type=icelake-MPI
pkgver=11.2.1
export _G4_INSTALL_PWD=/rds/projects/w/wheldonc-ambe-sims/Geant4/install/${_type}/Geant4-v${pkgver}/
export CFLAGS="-march=x86-64-v4 -Os -pipe -fno-plt -fexceptions -Wp,-D_FORTIFY_SOURCE=2 -Wformat -Werror=format-security -fstack-clash-protection -fcf-protection"
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
