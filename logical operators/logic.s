section .text
global _start

_start:
	MOV eax,0b1101
	MOV ebx,0b1010
	AND eax,ebx
	MOV eax,0b1101
	MOV ebx,0b1010
	OR eax,ebx
	MOV eax,0b1101
	MOV ebx,0b1010
	XOR eax,ebx
	MOV eax,0b1001
	NOT eax
	AND eax,0xF
	INT 80h
