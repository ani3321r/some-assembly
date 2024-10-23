extern test
extern exit

section .text
global main

main:
	PUSH 4
	PUSH 6
	CALL test
	PUSH eax
	CALL exit