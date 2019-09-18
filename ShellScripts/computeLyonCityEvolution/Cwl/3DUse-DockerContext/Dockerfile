# This file is an edition of the original 3DUse Dockerfile (Ubuntu
# 18.04 (located at
# https://github.com/MEPP-team/3DUSE/master/Docker/18.04/Dockerfile )
# The changes mainly concern using the ChangeDetection branch that
# offers some command line utilities (like SplitCityGMLBUildings)
FROM ubuntu:18.04
LABEL vendor="RICT project"

# Supposedly in order to avoid pesky messages of the form
#   "debconf: unable to initialize frontend: <...>"
ARG DEBIAN_FRONTEND=noninteractive

# Core dependencies
RUN apt-get update
RUN apt-get -y install sudo
RUN apt-get -y install wget
RUN apt-get -y install libboost-all-dev
RUN apt-get -y install libassimp-dev
RUN apt-get -y install libxml2-dev

# Notes concerning the GDAL dependency
# The last documented GDAL version in the 1.X series that worked with
# 3DUSE is 1.11.4. That version, does not seem to be packaged for
# Ubuntu 18.04. Note that adding the UbuntuGis ppa (as documeted
# on the mothergeo docs, cf
#    https://mothergeo-py.readthedocs.io/en/latest/development/how-to/gdal-ubuntu-pkg.html )
# fails with a message of the form
#    The repository
#    'http://ppa.launchpad.net/ubuntugis/ppa/ubuntu bionic Release'
#     does not have a Release file
#
# We thus proceed with a "manual" (out of the sources) installation that
# can be with the following commands (see below). Yet GDAL has many optional
# sub-dependencies (e.g. proj, json-c, libgeotiff, libtiff, libspatialite,
# liblwgeom 2.4.4) that are not automatically pulled by the following
# manual install. And by default when GDAL is not compiled without prior
# install of say libgeos-dev, then some methods will change their behavior
# and e.g. OGRPolygon::IsValid() will always return false.
# Prior to the "manual" install we thus need to pull the mandatory GDAL
# dependencies.
RUN sudo apt-get -y install libgeos-dev
RUN cd /tmp                                                       && \
    wget http://download.osgeo.org/gdal/1.11.4/gdal-1.11.4.tar.gz && \
    tar zxf gdal-1.11.4.tar.gz                                    && \
    cd gdal-1.11.4                                                && \
    mkdir $HOME/local/                                            && \
    ./configure --prefix=$HOME/local/gdal-1.11.4 --enable-shared  && \
    make                                                          && \
    make install

# Graphical User Interface dependencies
RUN apt-get -y install libopenscenegraph-dev
RUN apt-get -y install qt4-default libqt4-opengl-dev libqt4-dev

# Software engineering tools (build stages)
RUN apt-get -y install build-essential g++ # Pulls gcc, make...
RUN apt-get -y install git
RUN apt-get -y install cmake
RUN apt-get -y install wget

# PCL
# TRY TO FIX PCL INSTALL WITH https://larrylisky.com/2016/11/03/point-cloud-library-on-ubuntu-16-04-lts/
# No luck with PCL support on Ubuntu 18.04 because of the following error
# at compile time:
#    pcl-pcl-1.7.2/registration/include/pcl/registration/correspondence_estimation_normal_shooting.h:184:41:
#    error: return-statement with a value, in function returning
#    'void' [-fpermissive]
#         getKSearch () const { return (k_); }
# Skipping PCL building (and installation of its dependencies) and building
# 3DUSE without PCL support.
#
# PCL is optionnal: when selected it has its own sub-dependencies
# RUN apt-get -y install libeigen3-dev
# RUN apt-get -y install libflann-dev
# RUN apt-get -y install libqhull-dev
# RUN apt-get -y install libpng-dev   # libpng12 was dropped after 16.04
#
# For 3DUSE, a specific version of PCL is required. Proceed with manual install
# RUN cd /tmp &&                                 \
#    wget https://download.gforge.liris.cnrs.fr/meppbin/travis-trusty/pcl-pcl-1.7.2.travis-trusty.tgz && \
#    tar zxf pcl-pcl-1.7.2.travis-trusty.tgz && \
#    cd pcl-pcl-1.7.2/buildR &&                 \
#    make &&                                    \
#    make install  # Must be root

# Eventually install 3DUSE internal (embarked) dependencies
RUN cd                                                 && \
    git clone https://github.com/EricBoix/3DUSE        && \
    cd 3DUSE                                           && \
    git checkout ChangeDetection                       && \
    cd externals/laslib                                && \
    mkdir Build                                        && \
    cd Build                                           && \
    cmake .. -DCMAKE_BUILD_TYPE=Release                   \
             -DCMAKE_INSTALL_PREFIX=$HOME/local/laslib && \
    make                                               && \
    make install
# And terminate the install by building 3DUSE itself
RUN cd ~/3DUSE                                      && \
    mkdir Build                                     && \
    cd Build                                        && \
    cmake --verbose                                    \
    -DBUILD_GUI_QT4=ON                                 \
    -DLASLIB_INCLUDE_DIR=~/local/laslib/include        \
    -DLASLIB_LIBRARY=~/local/laslib/lib/liblaslib.a    \
    -DGDAL_LIBRARY=~/local/gdal-1.11.4/lib/libgdal.so  \
    -DGDAL_INCLUDE_DIR=~/local/gdal-1.11.4/include     \
    ..                                              && \
    make
    # Make install is brain damaged (and has been for quite
    # a long time)
    # make install

### Notes
# When running the container in interactive mode (-it) you might need
# some developement tools
#  - ccmake: sudo apt install cmake-curses-gui
#  - cgdb:   sudo apt install cgdb
