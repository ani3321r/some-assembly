section .data
	;char DB "A"
	;list DB 1,2,3,4,-1
	str1 DB "ABS",0
	str2 DB "EDC",0
section .text

global _start

_start:
	MOV bl,[str1]
	MOV eax,1
	INT 80h
