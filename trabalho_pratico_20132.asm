%include "asm_io.inc"

segment .data
	msg1	db	"Bye!", 0
	solucao	dd	0

segment .bss
	vetor1		resd	5
	vetor2		resd	5
	i			resb	1
	contador	resb	1

segment .text
	global  asm_main
        
asm_main:
	enter 0,0
	
	mov ebx, 0	
	mov ecx, 9
	lp1:
		call read_char
		cmp eax, ' '
		je nao_armazena
		mov [vetor1+ebx], eax
		add ebx, 4
		nao_armazena:
	loop lp1
	
	;inserindo a sequencia no vetor auxiliar:
	mov ecx, 5
	mov ebx, 0
	lp2:
		mov eax, [vetor1+ebx]
		mov [vetor2+ebx], eax
		add ebx, 4
	loop lp2
	
	call verifica
	
	mov eax, [solucao]
	call print_int
	leave
	ret

;pseudocódigo da função verifica:
;
;verifica():
;	i=0
;	conta()
;	while (i<17){					[vetor em dd]
;		if vetor2[i]==5{
;			empilha_i()
;			empilha_vetor()
;			vira(i)
;			verifica()
;			desempilha_vetor()
;			desempilha_i()
;		}
;		i=i+4						[vetor em dd]
;	}

verifica:
	mov eax, 0
	mov [i], eax
	enquanto:				;while do pseudocódigo:
		mov eax, [i]
		cmp eax, 17
		jnl fim_enquanto
	repita:
		mov ebx, [i]
		mov ecx, [vetor2+ebx]
		cmp ecx, 'P'			;if do pseudocódigo
		jne senao
		entao:
			;empilha a posicao i
			mov eax, [i]
			push eax
			;empilha vetor2 na pilha
			mov ecx, 5
			mov esi, vetor2
			lp3:
				lodsd
				push eax
			loop lp3
			call vira
			call conta
			call verifica			;chama função
			;remove os elementos da pilha e insere no vetor [OK]
			mov esi, esp
			mov ebx, 16
			mov ecx, 5
			lp4:
				pop eax
				mov [vetor2+ebx], eax
				sub ebx, 4
				lodsd
			loop lp4
			;remove a posicao da pilha [Acho que não precisa, mas deixa ai]
			pop eax
			mov [i], eax
		senao:
			mov ebx, [i]
			add ebx, 4
			mov [i], ebx
			mov eax, ebx
	jmp enquanto
	fim_enquanto:
		ret		
	
;pseudocódigo da função vira[i]:
;
;vira(i):
;	vetor2[i]='X'
;	if ((i-4)>=0){
;		if (vetor2[i-4]=='B') vetor2[i-4]='P'
;		else if (vetor2[i-4]=='P') vetor2[i-4]='B'
;	}
;	if ((i+4)<=16){
;		if (vetor2[i+4]=='B') vetor2[i+4]='P'
;		else if (vetor2[i+4]=='P') vetor2[i+4]='B'
;	}

vira:
	mov ebx, [i]
	mov ecx, 'X'
	mov [vetor2+ebx], ecx	;vetor2[i]='X'
	sub ebx, 4
	mov eax, ebx
	cmp ebx, 0				;if ((i-4)>=0)
	jl se_2
	entao_1:
		mov ecx, [vetor2+ebx]
		cmp ecx, 'B'			;if (vetor2[i-4]=='B')
		jne senao_1_1
		entao_1_1:
			mov ecx, 'P'
			mov [vetor2+ebx], ecx
			jmp se_2
		senao_1_1:
			cmp ecx, 'P'
			jne se_2
			entao_1_2:
				mov ecx, 'B'
				mov [vetor2+ebx], ecx
				jmp se_2
	se_2:
		mov ebx, [i]
		add ebx, 4
		mov eax, ebx
		cmp ebx, 16
		jg fim_vira
		entao_2:
			mov ecx, [vetor2+ebx]
			cmp ecx, 'B'
			jne senao_2_1
			entao_2_1:
				mov ecx, 'P'
				mov [vetor2+ebx], ecx
				jmp fim_vira
			senao_2_1:
				cmp ecx, 'P'
				jne fim_vira
				entao_2_2:
					mov ecx, 'B'
					mov [vetor2+ebx], ecx
					jmp fim_vira
	fim_vira:
		ret
		
;pseudocodigo da funcao conta
;
;solucao=0
;conta(){
;	contador=0
;	for (i=0; i<17; i=i+4){
;		if vetor2[i]=='X' contador++
;	}
;	if (contador==5) solucao++
;}

conta:
	mov eax, 0
	mov [contador], eax
	mov ebx, 0
	for:
		mov eax, [vetor2+ebx]
		cmp eax, 'X'
		je contaX
		jmp else
		contaX:
			mov eax, [contador]
			inc eax
			mov [contador], eax
			jmp else
		else:
			add ebx, 4
		cmp ebx, 17
		jl for
	fim_for:
		mov eax, [contador]
		cmp eax, 5
		je contaSolucao
		jmp fim_conta
		contaSolucao:
			mov eax, [solucao]
			add eax, 1
			mov [solucao], eax
		fim_conta:
			ret
			
imprimir_vetor2:
	mov ecx, 5
	mov ebx, 0
	lp5:
		mov eax, [vetor2+ebx]
		call print_char
		add ebx, 4
	loop lp5
	call print_nl
	ret
	
