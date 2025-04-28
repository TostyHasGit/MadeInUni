################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../hashmapv.cpp \
../main.cpp \
../pbma.cpp 

CPP_DEPS += \
./hashmapv.d \
./main.d \
./pbma.d 

OBJS += \
./hashmapv.o \
./main.o \
./pbma.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./hashmapv.d ./hashmapv.o ./main.d ./main.o ./pbma.d ./pbma.o

.PHONY: clean--2e-

