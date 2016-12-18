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
msg1	db	"Insira o ano: ",0
vetor	dd	10,10,10,10,10


;
; uninitialized data is put in the .bss segment
;
segment .bss
;
; These labels refer to double words used to store the inputs
;
input	resd 1
dendo	resd 1
saida	resd 1

;
; code is put in the .text segment
;
segment .text
        global  asm_main
asm_main:
        enter   0,0               ; setup routine
		
		mov eax, msg1
		call print_string
		call read_int
		mov [input], eax
		mov [dendo], eax
		jmp divisao
		
impressao:
		mov ebx, 0
		mov ecx, 5
		for2:
			mov eax, [vetor+ebx]
			call print_int
			call print_nl
			add ebx, 4
			loop for2

divisao:
		mov ebx, 0
		mov ecx, 5
		mov ax, [dendo]
		add ax, 1
		mov [saida], ax
		enquanto1:
			cmp ax, 0
			jne repita1
			jmp fim_enquanto1
		repita1:
			cwd
			mov cx, 10
			idiv cx
			mov [vetor+ebx], dx
			mov [dendo], ax
			add ebx, 4
			jmp enquanto1
		fim_enquanto1:
			jmp comparacao

comparacao:	
		mov al, 0	;contador numeros iguais
		mov edi, 0	;conta elemento vetor
		mov ebx, 4	;conta elemento vetor
		mov ecx, [vetor]
		mov edx, [vetor+4]
		enquantogeral:
			cmp edi, 17
			jl enquanto2
			jmp next
			enquanto2:
				cmp ebx, 17
				jl then1
				jmp fim_enquanto2
				then1:
					cmp ecx, edx
					je then2
					jmp else2
					then2:
						add al, 1
						jmp next
					else2:
						add ebx, 4
						mov edx, [vetor+ebx]
						jmp enquantogeral
			fim_enquanto2:
				add edi, 4
				mov ecx, [vetor+edi]
				mov eax, edi
				add eax, 4
				mov ebx, eax
				mov edx, [vetor+ebx]
				mov al, 0
				jmp enquantogeral
next:
		cmp al, 0
		je entao
		jmp senao
		entao:
			mov eax, [saida]
			call print_int
			call print_nl
			jmp prox
		senao:
			mov eax, [saida]
			mov [dendo], eax
			jmp divisao
		prox:
		leave                     
        ret
