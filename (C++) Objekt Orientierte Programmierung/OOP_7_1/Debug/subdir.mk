################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Sequence.cpp \
../gtest_main.cpp \
../pbma.cpp \
../test_sequence.cpp 

CPP_DEPS += \
./Sequence.d \
./gtest_main.d \
./pbma.d \
./test_sequence.d 

OBJS += \
./Sequence.o \
./gtest_main.o \
./pbma.o \
./test_sequence.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./Sequence.d ./Sequence.o ./gtest_main.d ./gtest_main.o ./pbma.d ./pbma.o ./test_sequence.d ./test_sequence.o

.PHONY: clean--2e-

