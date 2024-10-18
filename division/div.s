section .text
global _start

_start:
	MOV eax,13
	MOV ecx,2
	DIV ecx
	INT 80h