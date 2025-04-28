################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../IntVector.cpp \
../gtest_main.cpp \
../pbma.cpp \
../test_intvector1.cpp 

CPP_DEPS += \
./IntVector.d \
./gtest_main.d \
./pbma.d \
./test_intvector1.d 

OBJS += \
./IntVector.o \
./gtest_main.o \
./pbma.o \
./test_intvector1.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./IntVector.d ./IntVector.o ./gtest_main.d ./gtest_main.o ./pbma.d ./pbma.o ./test_intvector1.d ./test_intvector1.o

.PHONY: clean--2e-

