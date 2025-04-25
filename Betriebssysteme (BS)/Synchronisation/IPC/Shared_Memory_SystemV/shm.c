#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/ipc.h>
#include <sys/shm.h>
#include <wait.h>

#define LEN 10
#define SHM_KEY 999

int main()
{ 

  int shmid;
  int *seq, *seq_sort;
  int status, i;

  /* create and attach shared memory */
  if ((shmid = shmget(SHM_KEY, sizeof(int)*LEN, 
                IPC_CREAT | IPC_EXCL | 0666)) < 0) {
     perror("shmget");
     exit(-1);
  }

  if (( seq = (int*) shmat(shmid,NULL,0)) == (void*) -1) {
     perror("shmat");
     exit(-1);
  }

    if(fork() == 0) { 
	   // child process 
       for (int i=0; i<LEN; i++)
         printf("%d\n", seq[i]);
         /* detach und remove shared memory */
       if (shmdt(seq) == -1) {
         perror("shmdt");
         exit(-1);
        }  
       exit(0);
    }
    else {
	  //	parent process
      for (int i=0; i<LEN; i++)
         seq[i] = i;
      wait(NULL);

       /* detach und remove shared memory */
     if (shmdt(seq) == -1) {
       perror("shmdt");
       exit(-1);
     }

     if ( shmctl(shmid, IPC_RMID, NULL) == -1) {
        perror("shmctl");
        exit(1);
     }
   }
    return 0;
}



