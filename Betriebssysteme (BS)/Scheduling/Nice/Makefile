all : calc_sum system_load

calc_sum : calc_sum.cpp
	g++ calc_sum.cpp -o calc_sum

system_load : system_load.cpp
	g++ system_load.cpp -o system_load

clean :
	-rm calc_sum
	-rm system_load

run : calc_sum system_load
	mate-terminal -e  htop &
	sleep 10
	./system_load &
	./system_load &
	./system_load &
	./system_load &
	./system_load &
	./system_load &
	./system_load &
	./system_load &
	./zeiten "./calc_sum 10"
	./zeiten "./calc_sum 0"
	./zeiten "./calc_sum 20"
	killall system_load

