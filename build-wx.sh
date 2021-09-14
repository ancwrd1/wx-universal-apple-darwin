#!/bin/bash

basedir="$(cd $(dirname $0) && pwd -P)"
target="$basedir/build"
gitref=$(cat "$basedir/git-ref")
buildlog="$target/build.log"

mkdir -p $target
cd $target

rm -f $buildlog

if [[ ! -e "$target/wxWidgets/.git" ]]; then
    echo "Cloning wxWidgets repository"
    git clone --recurse-submodules https://github.com/wxWidgets/wxWidgets.git 2>>$buildlog >>$buildlog
    if [[ "$?" != "0" ]]; then
    echo "FATAL: error while running git clone, check $buildlog"
        exit 1
    fi
fi

echo "Checking out $gitref"
git -C wxWidgets checkout $gitref 2>>$buildlog >>$buildlog
git -C wxWidgets submodule update --recursive 2>>$buildlog >>$buildlog

mkdir -p darwin
cd darwin

echo "Configuring for cmake build"
cmake -DCMAKE_INSTALL_PREFIX=$target/target \
      -DCMAKE_SYSTEM_NAME=Darwin \
      -DCMAKE_OSX_ARCHITECTURES="x86_64;arm64" \
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
      ../wxWidgets 2>>$buildlog >>$buildlog

if [[ "$?" != "0" ]]; then
    echo "FATAL: error while running cmake, check $buildlog"
    exit 1
fi

echo "Building wxWidgets for macOS universal target"
ninja install 2>>$buildlog >>$buildlog

echo "Replacing headers and libraries"
rm -rf $basedir/include
rm -rf $basedir/lib

rsync -a $target/target/include $basedir/
rsync -a $target/target/lib $basedir/
