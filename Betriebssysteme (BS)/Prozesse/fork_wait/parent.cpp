#include <iostream>
#include <unistd.h>
#include <wait.h>

using namespace std;

int main(int argc, char *argv[]) {
  int pid;
  int status;

  if (argc < 3) {
    cerr << "Fehler, Programmargumente fehlen\n";
    return 1;
  }

  switch (pid = fork()) {/* Prozessduplikation */
  case -1:
    cerr << "Fehler bei fork" << endl;
    return 1;

  case 0: /* Sohnprozess */
    cout << "Sohn(in parent.cpp): PID " << getpid() << ", PPID " << getppid() << endl;
    cout << "Sohn(in parent.cpp): Wechsel nach Programm " << argv[2] << endl;
    if (execl(argv[1], argv[2], NULL) == -1) {
      cerr << "Sohn: Fehler bei exec" << endl;
      return 1;
    }
    cout << "Wird nie erreicht";

  default: /* Vaterprozess */
    cout << "Vater: PID "<<  getpid() << endl;
    cout << "Vater: Warten auf Ende des Sohnprozesses" << endl;
    if (wait(&status) != pid) {
      cerr << "Vater: Fehler bei wait" << endl;
      return 1;
    }
    cerr << "Vater: Sohn " << pid << " endet mit Status " << WEXITSTATUS(status) << endl; // least significant bits transport additional information
    return 0;
  }
}
