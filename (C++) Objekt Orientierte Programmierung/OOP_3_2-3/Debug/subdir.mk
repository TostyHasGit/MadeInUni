################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
CPP_SRCS += \
../Participant.cpp \
../Time.cpp \
../pbma.cpp \
../race_main.cpp 

CPP_DEPS += \
./Participant.d \
./Time.d \
./pbma.d \
./race_main.d 

OBJS += \
./Participant.o \
./Time.o \
./pbma.o \
./race_main.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.cpp subdir.mk
	@echo 'Building file: $<'
	@echo 'Invoking: GCC C++ Compiler'
	g++ -O0 -g3 -Wall -c -fmessage-length=0 -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '


clean: clean--2e-

clean--2e-:
	-$(RM) ./Participant.d ./Participant.o ./Time.d ./Time.o ./pbma.d ./pbma.o ./race_main.d ./race_main.o

.PHONY: clean--2e-

