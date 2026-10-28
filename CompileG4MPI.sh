#!/bin/bash
#SBATCH --time=00-00:05:00
#SBATCH --ntasks 10
#SBATCH --nodes 1
#SBATCH --qos bbshort
#SBATCH --mail-type ALL
#SBATCH --mem-per-cpu 4G
#SBATCH --account=wheldonc-ambe-sims


_type=generic-qt6-MPI
#_type=generic-MPI
pkgver=11.4.3
#pkgver=11.3.1
#pkgver=11.2.1

if [ $pkgver = 11.4.3 ]; then
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
elif [ $pkgver = 11.2.1 ] || [ $pkgver = 11.3.1 ]; then
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
fi

#make sure you are running the code from the directory you submitted from
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

rm -Rf /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/build/${_type}/${pkgver}-slurm
rm -Rf /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm
mkdir -p /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/build/${_type}/${pkgver}-slurm
mkdir -p /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm

cd /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/build/${_type}/${pkgver}-slurm
cmake -DCMAKE_BUILD_TYPE=Release -DGeant4_DIR=/rds/projects/w/wheldonc-ambe-sims/Geant4/install/${_type}/Geant4-v${pkgver}/lib64 -DCMAKE_INSTALL_PREFIX=/rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/source
make -j10
make install
if [ $pkgver = 11.4.3 ]; then
  ln -s /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm/lib /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm/lib64
elif [ $pkgver = 11.2.1 ] || [ $pkgver = 11.3.1 ]; then
  ln -s /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm/lib64 /rds/projects/w/wheldonc-ambe-sims/Geant4/MPI/Geant4-MPI/install/${_type}/${pkgver}-slurm/lib
fi
