section .text
global main

addTwo:
	ADD eax,ebx
	RET

main:
	MOV eax,5
	MOV ebx,9
	CALL addTwo
	MOV ebx,eax ;preserve values
	MOV eax,1
	INT 80h