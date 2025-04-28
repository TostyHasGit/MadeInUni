################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Bruch.cpp \
../gtest_main.cpp \
../test_bruch.cpp 

CPP_DEPS += \
./Bruch.d \
./gtest_main.d \
./test_bruch.d 

OBJS += \
./Bruch.o \
./gtest_main.o \
./test_bruch.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./Bruch.d ./Bruch.o ./gtest_main.d ./gtest_main.o ./test_bruch.d ./test_bruch.o

.PHONY: clean--2e-

