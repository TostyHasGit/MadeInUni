################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../dame.cpp \
../main.cpp \
../pbma.cpp \
../pbmag.cpp 

CPP_DEPS += \
./dame.d \
./main.d \
./pbma.d \
./pbmag.d 

OBJS += \
./dame.o \
./main.o \
./pbma.o \
./pbmag.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./dame.d ./dame.o ./main.d ./main.o ./pbma.d ./pbma.o ./pbmag.d ./pbmag.o

.PHONY: clean--2e-

