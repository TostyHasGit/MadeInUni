################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Queue.cpp \
../pbma.cpp \
../queuemain.cpp 

CPP_DEPS += \
./Queue.d \
./pbma.d \
./queuemain.d 

OBJS += \
./Queue.o \
./pbma.o \
./queuemain.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./Queue.d ./Queue.o ./pbma.d ./pbma.o ./queuemain.d ./queuemain.o

.PHONY: clean--2e-

