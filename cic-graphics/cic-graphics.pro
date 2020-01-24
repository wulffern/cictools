######################################################################
  ##        Copyright (c) 2015 Carsten Wulff Software, Norway
  ## ###################################################################
  ## Created       : wulff at 2015-8-20
  ## ###################################################################
  ##   This program is free software: you can redistribute it and/or modify
  ##   it under the terms of the GNU General Public License as published by
  ##   the Free Software Foundation, either version 3 of the License, or
  ##   (at your option) any later version.
  ##
  ##   This program is distributed in the hope that it will be useful,
  ##   but WITHOUT ANY WARRANTY ; without even the implied warranty of
  ##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ##   GNU General Public License for more details.
  ##
  ##   You should have received a copy of the GNU General Public License
  ##   along with this program.  If not, see <http://www.gnu.org/licenses/>.
  ######################################################################

  QT += core widgets

  CONFIG += qt 
  CONFIG += staticlib
  CONFIG += c++11

  mac {
  #- This needs to point to the SDK usually in /Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/
    mac::QMAKE_MAC_SDK = macosx10.15

  }
  TEMPLATE = lib

  TARGET = cic-graphics


  osx:DESTDIR = ../lib/darwin
  linux:DESTDIR = ../lib/linux
  win32:DESTDIR = ../lib/windows

  #- Add coverage information
  QMAKE_CFLAGS += $$(CFLAGS)
  QMAKE_LFLAGS += $$(LDFLAGS)

  OBJECTS_DIR=build
  MOC_DIR=build

  DEPENDPATH +=.

  INCLUDEPATH += src/ ../../ciccreator/cic-core/src

  # Input
  HEADERS +=  src/painter/cellpainter.h  \
  src/printer/eps.h \
  src/printer/minecraft.h \
  src/printer/svg.h \
  src/printer/tikz.h \


  SOURCES +=  src/painter/cellpainter.cpp \
  src/printer/eps.cpp \
  src/printer/minecraft.cpp \
  src/printer/svg.cpp \
  src/printer/tikz.cpp \

  CIC_CORE_LIB=../../ciccreator/lib
win32: LIBS += -L$$PWD/$$CIC_CORE_LIB/windows/ -lcic
else:linux: LIBS += -L$$PWD/$$CIC_CORE_LIB/linux/ -lcic
else:mac: LIBS += -L$$PWD/$$CIC_CORE_LIB/darwin/ -lcic


mac:PRE_TARGETDEPS += $$CIC_CORE_LIB/darwin/libcic$${LIBSUFFIX}.a
mac:INCLUDEPATH += $$PWD/$$CIC_CORE_LIB/darwin
mac:DEPENDPATH += $$PWD/$$CIC_CORE_LIB/darwin

                   
linux:PRE_TARGETDEPS += $$CIC_CORE_LIB/linux/libcic$${LIBSUFFIX}.a
linux:INCLUDEPATH += $$PWD/$$CIC_CORE_LIB/linux
linux:DEPENDPATH += $$PWD/$$CIC_CORE_LIB/linux

win32:PRE_TARGETDEPS += $$CIC_CORE_LIB/windows/libcic$${LIBSUFFIX}.a
win32:INCLUDEPATH += $$PWD/$$CIC_CORE_LIB/windows
win32:DEPENDPATH += $$PWD/$$CIC_CORE_LIB/windows

