/* Beispiel FIFO-Datei */
/* Programm producer.cpp - Erzeuger */

#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <iostream>
#include <string>

#define BUFLEN 80 

using namespace std;

int main(int argc, char* argv[])
{
  int aus;
  
  string buffer;
  int i;

  if (argc != 2)
    { cout << "Erzeuger: Fehler beim Aufruf\n";
      exit(1);
    }
  if ((aus = open(argv[1], O_WRONLY)) == -1)
    {  cout << "Erzeuger: Fehler beim Oeffnen der Pipe\n";
      exit(1);
    }
  do 
  { cout << "Eingabe: ";
	 getline (cin, buffer); 
    if (write(aus, buffer.c_str(), BUFLEN) != BUFLEN)
      { cout << "Erzeuger: Fehler beim Schreiben\n";
        exit(1);
       }
  } while (buffer != "End");
  close(aus);
  exit(0);
} 


