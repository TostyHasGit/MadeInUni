/* Beispiel FIFO-Datei
/* Programm consumer.cpp - Verbraucher */

#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>

#define BUFLEN 80

using namespace std;

int main(int argc, char *argv[])
{
  int ein;
  char buffer[BUFLEN];
  int i;
  
  if (argc != 2)
    { cout << "Verbraucher: Fehler beim Aufruf\n";
      exit(1);
    }
  if (( ein = open(argv[1], O_RDONLY)) == -1)
    { cout << "Verbraucher: Fehler beim Oeffnen der Pipe\n";
      exit(1);
    }
  while (read(ein, buffer, BUFLEN) != 0)  
    cout << buffer << endl;
  close(ein);
  exit(0);
}  

