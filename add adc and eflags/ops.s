section .data

section .text

global _start

_start:
	MOV al,0b11111111
	MOV bl,0b0001
	ADD al,bl
	ADC ah, 0  ;in order to get the carry value
	INT 80h