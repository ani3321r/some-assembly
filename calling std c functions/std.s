extern printf
extern exit

section .data
	msg DD "Hello Raiden!",0
	fmt DB "Output is: %s",10,0
section .text

global main

main:
	PUSH msg
	PUSH fmt
	CALL printf
	PUSH 1
	CALL exit