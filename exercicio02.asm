%include "asm_io.inc"
;
; initialized data is put in the .data segment
;
segment .data
;
;
msg1	db	"Digite a frase: ",0

;
; uninitialized data is put in the .bss segment
;
segment .bss
;
;
frase	resb	25
saida	resb	25


segment .text
        global  asm_main
asm_main:

		enter   0,0
		pusha

		mov eax, msg1
        call print_string

		mov	ecx, 25
		mov	edi, frase
		lp1:
			call read_char
			stosb
		loop lp1

		mov	ecx, 25
		mov	esi, frase
		mov	ebx, 0
		mov	edi, saida

		repita:
			lodsb
			cmp	eax, 32

			mov	edx, ecx
			mov	ecx, ebx
			je	inverter
			push eax
			inc	ebx
			fn:
				mov	ecx, edx
		loop repita
	
		cmp ebx, 0
		mov	ecx, ebx
		jne inverter
		jmp	imprime_vetor

		inverter:
			pop	eax
			stosb
			dec	ebx
		loop inverter
		
		mov	eax, 32
		stosb
		mov	eax, ebx
		jmp	fn

		imprime_vetor:
			mov	ecx, 25
			mov	esi, saida
			repita1:
				lodsb
				call print_char	
			loop repita1
			popa

	leave        
    ret 
