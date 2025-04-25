// C program to demonstrate use of fork() and pipe()
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>
 
int main()
{
     
    int fd1[2]; // Used to store two ends of first pipe
    
    char input_str[100];
    char receive_str[100];
    
    pid_t p;
 
    if (pipe(fd1) == -1) {
        fprintf(stderr, "Pipe Failed");
        return 1;
    }
   
    p = fork();
 
    if (p < 0) {
        fprintf(stderr, "fork Failed");
        return 1;
    }
 
    // Parent process
    else if (p > 0) {
		
	    close(fd1[0]); // Close reading end of first pipe
	    printf("Enter string, to send: ");
        scanf("%s", input_str);
 
        write(fd1[1], input_str, strlen(input_str) + 1);
        
        close(fd1[1]);  // Close reading end of first pipe
        printf("Process %d wrote into pipe: %s\n", getpid(), input_str);
 
        // Wait for child
        wait(NULL);
    }
 
    // child process
    else {
        close(fd1[1]); // Close writing end of first pipe
 
        // Read a string using pipe
        read(fd1[0], receive_str, 100);
        printf("Process %d received from pipe: %s\n", getpid(), receive_str);
 
        close(fd1[0]); // Close reading end of first pipe

        exit(0);
    }
}
