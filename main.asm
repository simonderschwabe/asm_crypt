.include "definitions.asm"


.intel_syntax noprefix

.section .data

.section .bss
.lcomm key_buffer, 10240
.lcomm data_buffer, BLOCK_SIZE

.section .text

####### STACK ###########
##	16 -> OutputFile Parameter
## 	12 -> InputFile Parameter
##	8 -> KeyFile Parameter
## ebp ->
#########################

.globl _start

_start:

###########################################################
## Reading KeyFile
###########################################################
	mov ebp, esp

	call argv_number
	cmp eax, 4
	jl exit_error 
	
	push 0666
	push 0
	push [ebp+8]
	call file_open
	add esp, 12

	# Creating Space for FD_IN, FD_OUT, Key
	sub esp, 12
	mov ebp, esp

	# Save FD of Key to Stack
	mov [ebp+4], eax

	lea eax, key_buffer

	push 10240
	push eax
	push [ebp+4]
	call file_read
	add esp, 12

	# Save length to Stack
	mov [ebp+8], eax 

	push [ebp+4]
	call file_close
	add esp, 4

#############################################################
## Reading Input File
#############################################################	
####### STACK #########
## 	28 -> OutputFile
##	24 -> Input File
##	20 -> Key File
##	16 -> Program Executable Name
##	12 -> FD_OUT
##	8  -> Key_length
##	4  -> FD_IN
## ebp ->
#######################

	push 0666
	push 0
	push [ebp+24]
	call file_open
	add esp, 12

	# Save FD Input File to Stack
	mov [ebp+4], eax 

	push 0666
	push 03101
	push [ebp+28]
	call file_open
	add esp, 12

	# Save FD Output File to Stack
	mov [ebp+12], eax

	lea eax, key_buffer
	lea ebx, data_buffer

	push ebx
	push [ebp+12]
	push [ebp+4]
	push eax
	push [ebp+8]
	call crypt_xor
	add esp, 16

	push [ebp+4]
	call file_close
	add esp, 4

	push [ebp+12]
	call file_close
	add esp, 4

	jmp exit

exit:
	mov eax, 1
	mov ebx, 0 
	int 0x80

exit_error:

	mov eax, 1
	mov ebx, 1
	int 0x80

