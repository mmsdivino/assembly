%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
; These labels refer to strings used for output
;
;prompt1 db    "Enter a number: ", 0       ;don't forget nul terminator
;prompt2 db    "Enter another number: ", 0
;outmsg1 db    "You entered ", 0
;outmsg2 db    " and ", 0
;outmsg3 db    ", the sum of these is ", 0
msg1	db	"Insira os numeros no vetor: ",0

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


;
; code is put in the .text segment
;
segment .text
    global  asm_main
asm_main:
    enter   0,0               ; setup routine

	mov eax, msg1
	call print_string
	call print_nl
	mov ebx, 0
	mov ecx, 10
	for_1:
		call read_int
		mov [vetor+ebx], eax
		add ebx, 4
		loop for_1
	call print_nl

bubbleSort:
	mov si, 0
	mov ebx, 0	;conta elemento vetor
	mov ecx, 4	;conta elemento vetor
	mov eax, [vetor]	;eax=[vetor+ebx]
	mov edx, [vetor+4]	;edx=[vetor+ecx]
	enquanto_geral:
		cmp ebx, 37
		jl enquanto_1
		jmp fimEnquanto_1
		enquanto_1:
			cmp ecx, 37
			jl then_1
			jmp fimEnquanto_1
			then_1:
				cmp eax, edx
				jg then_2
				jmp else_2
				then_2:
					mov [vetor+ebx], edx
					mov [vetor+ecx], eax
					add si, 1
					jmp else_2
				else_2:
					add ebx, 4
					mov eax, [vetor+ebx]
					add ecx, 4
					mov edx, [vetor+ecx]
					jmp enquanto_geral
			fimEnquanto_1:
				cmp si,0
				je impressao
				jmp bubbleSort

impressao:
		mov ebx, 0
		mov ecx, 10
		for_2:
			mov eax, [vetor+ebx]
			call print_int
			call print_nl
			add ebx, 4
			loop for_2
        leave                     
        ret
