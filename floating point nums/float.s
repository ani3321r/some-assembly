section .data
	x DD 2.66
	y DD 5.89

section .text
global _start

_start:
	MOVSS xmm0, [x]
	MOVSS xmm1, [y]
	ADDSS xmm0, xmm1
	MOV ebx,4
	INT 80h