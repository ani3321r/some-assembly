section .data
	x DD 6.28
	y DD 1.22

section .text
global _start

_start:
	MOVSS xmm0,[x]
	MOVSS xmm1,[y]
	UCOMISS xmm0,xmm1
	JA greater
	JMP end

greater:
	MOV ecx,1

end:
	MOV eax,1
	MOV ebx,1
	INT 80h