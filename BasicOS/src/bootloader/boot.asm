ORG 0x7C00
BITS 16

JMP SHORT main
NOP

bdb_oem:	                DB  'MSWIN4.1'
bdb_bytes_per_sector:	    DW  512
bdbc_sectors_per_cluster: DB  1
bdb_reserved_sectors:	    DW  1
bdb_fat_count:		        DB  2
bdb_dir_entries_count:    DW  0E0h
bdb_total_sectors:	      DW  2880
bdb_media_descriptor_type: DB 0F0h
bdb_sectors_per_fat:	    DW  9
bdb_sectors_per_track:    DW  18
bdb_heads: 		            DW  2
bdb_hidden_sectors:	      DD  0
bdb_large_sector_count:	  DD  0

ebr_drive_number:	  DB  0
			              DB  0
ebr_signature:		  DB  29h
ebr_volume_id: 	 	  DB  12h,34h,56h,78h
ebr_volume_label:	  DB  'BASIC OS   '
ebr_system_id:		  DB  'FAT12   '

main:
	MOV ax,0
	MOV ds,ax
	MOV es,ax
	MOV ss,ax

	MOV sp,0x7C00

	MOV [ebr_drive_number], dl
	MOV ax,1
	MOV cl,1
	MOV bx,0x7E00
	call disk_read

	MOV si,boot_msg
	CALL print
	HLT

halt:
	JMP halt

lba_to_chs:
	PUSH ax
	PUSH dx

	XOR dx,dx
	DIV word[bdb_sectors_per_track] ;(LBA % sectors per track) + 1 <- sector
	INC dx
	MOV cx,dx

	XOR dx,dx
	;head: (LBA/sectors per track) % number of heads
	MOV dh,dl
	MOV ch,al
	SHL ah,6
	;cylinder: (LBA / sectors per track) / number of heads
	OR CL,AH


	POP ax
	MOV dl,al
	POP ax

	RET

disk_read:
	PUSH ax
	PUSH bx
	PUSH cx
	PUSH dx
	PUSH di

	call lba_to_chs

	MOV ah,02h
	MOV di,3 ;cnt

retry:
	STC
	INT 13h
	jnc doneRead
	
	call diskReset

	DEC di
	TEST di,di
	JNZ retry

failRead:
	MOV si,read_faliure
	CALL print
	HLT
	JMP halt

diskReset:
	pusha
	MOV ah,0
	STC
	INT 13h
	JC failRead
	POPA
	RET

doneRead:
	pop di
	pop dx
	pop cx
	pop bx
	pop ax

	ret


print:
	PUSH si
	PUSH ax
	PUSH bx

print_loop:
	LODSB
	OR al,al
	JZ done_print

	MOV ah, 0x0E
	MOV bh, 0
	INT 0x10

	JMP print_loop

done_print:
	POP bx
	POP ax
	POP si
	RET

boot_msg: DB 'OS BOOTED', 0x0D, 0x0A, 0
read_faliure DB 'failed to read disk', 0x0D, 0x0A, 0

TIMES 510-($-$$) DB 0
DW 0AA55h