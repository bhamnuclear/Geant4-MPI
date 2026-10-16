#!/bin/bash
mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=../install -DCMAKE_BUILD_TYPE=Release ../source -DCMAKE_POLICY_VERSION_MINIMUM=4.0
make
make install
cd ..
