%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
;prompt1 db    "Enter a number: ", 0       ; don't forget nul terminator
;prompt2 db    "Enter another number: ", 0
;outmsg1 db    "You entered ", 0
;outmsg2 db    " and ", 0
;outmsg3 db    ", the sum of these is ", 0
msg1	db	"Insira 10 numeros: ",0
;msg2	db	"Maior: ",0
;msg3	db	"Menor: ",0
msg4	db	"Amplitude: ",0


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
;input1  resd 1
;input2  resd 1
vetor	resd 10
maior	resd 1
menor	resd 1

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
		push ebx
		
		mov eax, msg1
		call print_string

		mov ebx, 0
		mov ecx, 10
		for1:
			call read_int
			mov [vetor+ebx], eax
			add ebx, 4
			loop for1
		
		mov ebx, 4
		mov ecx, 10
		mov eax, [vetor]
		mov [maior], eax
;		mov eax, [vetor]
		mov [menor], eax
		for3:
			mov eax, [maior]
			cmp [vetor+ebx], eax
			jge then
			jmp elseif
			then:
				mov eax, [vetor+ebx]
				mov [maior], eax
			elseif:
				mov eax, [menor]
				cmp [vetor+ebx], eax
				jle thenelseif
				jmp next
			thenelseif:
				mov eax, [vetor+ebx]
				mov [menor], eax
			next:
				add ebx, 4
				loop for3
		
		mov eax, msg4
		call print_string
		mov eax, [maior]
		sub eax, [menor]
		call print_int
		
;		mov ebx, 0
;		mov ecx, 10
;		for2:
;			mov eax, [vetor+ebx]
;			call print_int
;			add ebx, 4
;			loop for2
		
;		mov eax, msg2
;		call print_string
;		mov eax, [maior]
;		call print_int
;		
;		mov eax, msg3
;		call print_string
;		mov eax, [menor]
;		call print_int
;		
        leave                     
        ret
