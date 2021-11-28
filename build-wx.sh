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
    git clone -n --recurse-submodules https://github.com/wxWidgets/wxWidgets.git 2>>$buildlog >>$buildlog
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

export MACOSX_DEPLOYMENT_TARGET="10.13"

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
      -DwxBUILD_COMPATIBILITY=3.1 \
      -DwxBUILD_MONOLITHIC=ON \
      -DwxBUILD_OPTIMISE=ON \
      -DwxBUILD_SHARED=OFF \
      -DwxBUILD_DEBUG_LEVEL=0 \
      -DwxUSE_STL=ON \
      -DwxUSE_WEBVIEW=ON \
      -DwxUSE_HTML=ON \
      -DwxUSE_LIBMSPACK=OFF \
      -DwxUSE_LOG=OFF \
      -DwxUSE_LOGGUI=OFF \
      -DwxUSE_LOGWINDOW=OFF \
      -DwxUSE_LOG_DIALOG=OFF \
      -DwxUSE_DOC_VIEW_ARCHITECTURE=OFF \
      -DwxUSE_HELP=OFF \
      -DwxUSE_MS_HTML_HELP=OFF \
      -DwxUSE_WXHTML_HELP=OFF \
      -DwxUSE_AUI=OFF \
      -DwxUSE_PROPGRID=OFF \
      -DwxUSE_RIBBON=OFF \
      -DwxUSE_STC=OFF \
      -DwxUSE_MDI=OFF \
      -DwxUSE_MDI_ARCHITECTURE=OFF \
      -DwxUSE_MEDIACTRL=OFF \
      -DwxUSE_RICHTEXT=OFF \
      -DwxUSE_POSTSCRIPT=OFF \
      -DwxUSE_AFM_FOR_POSTSCRIPT=OFF \
      -DwxUSE_PRINTING_ARCHITECTURE=OFF \
      -G Ninja \
      ../wxWidgets 2>>$buildlog >>$buildlog

if [[ "$?" != "0" ]]; then
    echo "FATAL: error while running cmake, check $buildlog"
    exit 1
fi

echo "Building wxWidgets for macOS universal target"
ninja install 2>>$buildlog >>$buildlog

if [[ "$?" != "0" ]]; then
    echo "FATAL: error while running ninja, check $buildlog"
    exit 1
fi

echo "Replacing headers and libraries"
rm -rf $basedir/include
rm -rf $basedir/lib

rsync -a $target/target/include $basedir/
rsync -a $target/target/lib $basedir/
