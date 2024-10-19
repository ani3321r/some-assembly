section .text
global _start

_start:
	MOV eax,12
	SHR eax,2
	INT 80h