################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../pbma.cpp \
../pbmag.cpp \
../zeichnepl.cpp 

CPP_DEPS += \
./pbma.d \
./pbmag.d \
./zeichnepl.d 

OBJS += \
./pbma.o \
./pbmag.o \
./zeichnepl.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./pbma.d ./pbma.o ./pbmag.d ./pbmag.o ./zeichnepl.d ./zeichnepl.o

.PHONY: clean--2e-

