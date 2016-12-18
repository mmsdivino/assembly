%include "asm_io.inc"
extern printf

segment .data
msg	db	"%f",0x0a,0x00

segment .bss
n1  		resd 1
n2			resd 1
resultado	resq	1


segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine

        call read_int
        mov [n1], eax
        call read_int
        mov [n2], eax
        
        fild dword [n1]
        
        fidiv dword [n2]
        
        fstp qword [resultado]
        
        push dword [resultado+4]
        push dword [resultado]
        push dword msg
        call printf
        add esp, 12
        
        leave                     
        ret


