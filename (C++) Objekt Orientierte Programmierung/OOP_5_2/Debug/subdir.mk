################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Bruch.cpp \
../bruchrechnen.cpp 

CPP_DEPS += \
./Bruch.d \
./bruchrechnen.d 

OBJS += \
./Bruch.o \
./bruchrechnen.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./Bruch.d ./Bruch.o ./bruchrechnen.d ./bruchrechnen.o

.PHONY: clean--2e-

