section .text
global _start

_start:
	MOV al,0xFF
	MOV bl,3
	IMUL bl
	INT 80h