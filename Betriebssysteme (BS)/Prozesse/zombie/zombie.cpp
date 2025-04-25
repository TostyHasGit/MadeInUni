#include <iostream>
#include <cstdio>
#include <unistd.h>
#include <wait.h>

using namespace std;

int main() {
   int pid;
   int status;
   
   switch (pid = fork())
   {
     case -1 : cerr << "error in fork" << endl;
               break;
     case 0  : return 0;
     
     default: cout << "Enter <CR> to remove Zombie" << endl;
              getchar();
              wait(&status);
   }
   exit (0);
}
	        
