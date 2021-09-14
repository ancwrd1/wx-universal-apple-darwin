#!/bin/bash

ARCHES="x86_64;arm64"

cmake -DCMAKE_INSTALL_PREFIX=/opt/wx/universal-apple-darwin \
      -DCMAKE_SYSTEM_NAME=Darwin \
      -DCMAKE_OSX_ARCHITECTURES="$ARCHES" \
      -DCMAKE_OSX_SYSROOT="$(xcrun -show-sdk-path)" \
      -DCMAKE_CXX_STANDARD=14 \
      -DCMAKE_C_COMPILER="$(xcrun -f clang)" \
      -DCMAKE_CXX_COMPILER="$(xcrun -f clang++)" \
      -DCMAKE_AR=$(xcrun -f ar) \
      -DCMAKE_RANLIB=$(xcrun -f ranlib) \
      -DCMAKE_BUILD_TYPE=Release \
      -DwxBUILD_MONOLITHIC=ON \
      -DwxUSE_STL=ON \
      -DwxUSE_WEBVIEW=ON \
      -DwxBUILD_COMPATIBILITY=3.1 \
      -DwxBUILD_OPTIMISE=ON \
      -DwxBUILD_SHARED=OFF \
      -DwxUSE_LIBMSPACK=OFF \
      -G Ninja \
      ../wxWidgets
