######################################################################
##        Copyright (c) 2016 Carsten Wulff Software, Norway 
## ###################################################################
## Created       : wulff at 2016-1-29
## ###################################################################
##   This program is free software: you can redistribute it and/or modify
##   it under the terms of the GNU General Public License as published by
##   the Free Software Foundation, either version 3 of the License, or
##   (at your option) any later version.
## 
##   This program is distributed in the hope that it will be useful,
##   but WITHOUT ANY WARRANTY; without even the implied warranty of
##   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
##   GNU General Public License for more details.
## 
##   You should have received a copy of the GNU General Public License
##   along with this program.  If not, see <http://www.gnu.org/licenses/>.
######################################################################

VERSION=0.1.2

#- Figure out which platform we're running on
ifeq ($(OS),Windows_NT)
	#- Not compatible with windows yet
OSNAME=Windows
OSBIN=windows
GDS3D=WINDOWS
else
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
OSNAME=macOS
OSBIN=darwin
GDS3D=GDS3D/mac/GDS3D.app/Contents/MacOS/GDS3D
endif
ifeq ($(UNAME_S),Linux)
OSNAME=Linux
OSBIN=linux
GDS3D=GDS3D/linux/GDS3D
endif
endif

ifeq ($(UNAME_S),Darwin)
CIC2EPS=time ../bin/${OSBIN}/cic2eps.app/Contents/MacOS/cic2eps
else
CIC2EPS= time ../bin/${OSBIN}/cic2eps
endif

ifeq ($(UNAME_S),Darwin)
CIC2PNG=time ../bin/${OSBIN}/cic2png.app/Contents/MacOS/cic2png
else
CIC2PNG= time ../bin/${OSBIN}/cic2png
endif

ifeq ($(UNAME_S),Darwin)
CIC2SCR=time ../bin/${OSBIN}/cic2scriptcraft.app/Contents/MacOS/cic2scriptcraft
else
CIC2SCR= time ../bin/${OSBIN}/cic2scriptcraft
endif

ifeq ($(UNAME_S),Darwin)
CIC2TIKZ=time ../bin/${OSBIN}/cic2tikz.app/Contents/MacOS/cic2tikz
else
CIC2TIKZ= time ../bin/${OSBIN}/cic2tikz
endif

ifeq ($(UNAME_S),Darwin)
CIC2GUI=time ../bin/${OSBIN}/cic-gui.app/Contents/MacOS/cic-gui
else
CIC2GUI= time ../bin/${OSBIN}/cic-gui
endif

EXAMPLE=../examples
CICEXAMPLE=../../ciccreator/examples
LAY=../../ciccreator/lay
CELL=SAR9B_EV
LIBNAME=SAR_ESSCIRC16_28N

#ifeq ($(UNAME_S),Darwin)
#CIC=time ../bin/${OSBIN}/cic.app/Contents/MacOS/cic
#else
#CIC= time ../bin/${OSBIN}/cic
#endif


all: qmake compile


qmake:
	qmake -o qmake.make cictools.pro 

#- Use a wrapper around qmake, I like defining my own makefiles
compile:
	${MAKE} -f qmake.make

test: eps png minecraft png tikz

eps:
	cd lay	; ${CIC2EPS} ${LAY}/${LIBNAME}.cic ${EXAMPLE}/tech_eps.json ${CELL}

png:
	cd lay	; ${CIC2PNG} ${LAY}/${LIBNAME}.cic ${EXAMPLE}/tech_eps.json ../examples/SAR_ESSCIRC16_28N.hier

minecraft:
	cd lay	; ${CIC2SCR} ${LAY}/${LIBNAME}.cic ${EXAMPLE}/tech_minecraft.json ${CELL}

tikz:
	cd lay	; ${CIC2TIKZ} ${LAY}/${LIBNAME}.cic ${EXAMPLE}/tech_tikz.json ${CELL}

gui:
	cd lay	; ${CIC2GUI} ${LAY}/${LIBNAME}.cic ${CICEXAMPLE}/tech.json ${CELL}



clean:
	${MAKE} -f qmake.make clean
	-rm cic-graphics/Makefile
	-rm cic-gui/Makefile
	-rm cic2eps/Makefile
	-rm cic2png/Makefile
	-rm cic2scriptcraft/Makefile
	-rm cic2tikz/Makefile
	-rm qmake.make
	-rm lay/*

help:
	@echo "make  			Compile all"
	@echo "make gui 		Clean all"
	@echo "make eps 		Run cic2eps"
	@echo "make png 		Run cic2png"
	@echo "make minecraft 		Run cic2scriptcraft"
	@echo "make tikz 		Run cic2tikz"
	@echo "make gui 		Run cic-gui"
	@echo "make gui 		Clean all"

	
	

