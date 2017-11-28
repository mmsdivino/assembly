%include "asm_io.inc"

segment .data
msg1	db	"Digite o valor de n: ",0

segment .bss
number	resb	1

segment .text
  global  asm_main
        
asm_main:
	enter 0,0
	
	mov eax, msg1
	call print_string
    
    call read_int
    mov [number], eax
    push eax
    call fibonacci
    pop eax
    
    mov eax, [number]
    cmp eax, 0
    je print_caso0
    cmp eax, 1
    je print_caso1
    mov eax, edx
    call print_int
    call print_nl
    leave
    ret

fibonacci:
	push ebp
	push ebx
	mov ebp, esp
	add ebp, 12
	mov ebx, [ebp]
	
	cmp ebx, 1
	jle caso_base
	
	mov edx, ebx
	dec edx
	push edx
	call fibonacci
	pop edx
	
	push eax
	mov edx, ebx
	sub edx, 2
	push edx
	call fibonacci
	pop edx
	pop edx
	add eax, edx
	jmp fim

caso_base:
	mov eax, 1

fim:
	pop ebx
	pop ebp
	ret

print_caso0:
	mov eax, 0
	call print_int
	call print_nl
	leave
	ret
	
print_caso1:
	mov eax, 1
	call print_int
	call print_nl
	leave
	ret
