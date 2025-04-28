all: hello global  multi_fork  multi_fork_commented

hello: hello.cpp
	g++ hello.cpp -o hello

global: global.cpp
	g++ global.cpp -o global
	
multi_fork: multi_fork.cpp
	g++ multi_fork.cpp -o multi_fork	
	
multi_fork_commented: multi_fork_commented.cpp
	g++ multi_fork_commented.cpp -o multi_fork_commented
	
clean:
	-rm global multi_fork hello
