.section .data
hello: .ascii "Hello World!\n"
.section .text
.globl _start
_start:
   mov $4, %eax     # 4 fuer den Syscall 'write'
   mov $1, %ebx     # File Descriptor
   mov $hello, %ecx # Speicheradresse des Textes
   mov $13, %edx    # Laenge des Textes
   int $0x80        # und los
   mov $1, %eax     # das
   mov $0, %ebx     # uebliche
   int $0x80        # beenden 
