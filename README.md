## Description

Modified develop enviroment for STM32F103C8T6 (BluePill) from Warren Gay book
"Beginning STM32 Developing with FreeRTOS, libopencm3 and GCC". It is necessary to use a ST-Link for flashing the microcontroller.

@author: Rolan Adair Bacilio Anota


### Installing:
-Install Arm-none-eabi toolchain:

		sudo apt-get install gcc-arm-none-eabi

-Install St-Link:
		sudo apt-get install stlink-tool

-At "include" folder run:
		git clone git://github.com/libopencm3/libopencm3.git

-Download FreeRTOS from https://www.freertos.org/. Add FreeRTOSvXX.X.X folder in "include/rtos". Aditionally you have to  edit the variable FREERTOS on STM32BluePill/NewProjectRTOS.mk like this:

		FREERTOS	?= FreeRTOSv10.2.1

-On STM32BluePill run
		make



### Create a Proyect:


In STM32BluePill folder

	For libopemcm3 projects
		make -f NewProjectM3.mk  PROJECT=newproject

	For FreeRTOS projects
		make -f NewProjectRTOS.mk  PROJECT=newproject


The proyects are stored in src folder with the name "newproject".


### Compile Proyect:


in src/"myPROYECT" you have to run 

		make


### FLASHING BIN:


in src/"myPROYECT" you have to run:

		make flash





Notes:
======

1. When compiling and you get the error message getline.c:5:20: fatal error: memory.h: No such file or directory, at the line where it is coded as "#include <memory.h>", you may have to change that to "#include <string.h>" instead. The compiler folks have sometimes moved the header file.

1. It has been reported that: Kubuntu 18.04 ships with arm-none-eabi-gcc (15:6.3.1+svn253039-1build1) 6.3.1 20170620, with this compiler the code does not work (creates problems for FreeRTOS). memcpy seems to be the problematic function call in the code, it is called by FreeRTOS when adding an element to the queue. (details in the FreeRTOS discussion on SourceForge)
