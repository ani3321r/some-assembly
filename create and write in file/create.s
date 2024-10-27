section .data
	pathname DD "/home/fatbrad/assembly_code/test_file/test3.txt"
	toWrite DD "Hello Raiden",0AH,0DH,"$"
section .text
global main

main:
	MOV eax,5
	MOV ebx,pathname
	MOV ecx,101o
	MOV edx,700o
	INT 80h

	MOV ebx,eax
	MOV eax,4
	MOV ecx,toWrite
	MOV edx,15
	INT 80h

	MOV eax,1
	MOV ebx,0
	INT 80h