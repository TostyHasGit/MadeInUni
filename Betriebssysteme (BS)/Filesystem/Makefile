all: mycopy random100MB.bin

mycopy: mycopy.cpp
	g++ -O3 mycopy.cpp -o mycopy

memmap: memmap.cpp
	g++ -O3 memmap.cpp -o memmap

random100MB.bin:
	head -c 100m /dev/urandom > random100MB.bin

clean:
	rm mycopy
	rm random100MB.bin*

