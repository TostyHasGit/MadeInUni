matrix: matrix.cpp
	g++ matrix.cpp -o matrix

run: matrix
	systemd-run --scope -p MemoryLimit=500M  ./matrix

clean:
	-rm matrix
