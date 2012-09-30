.include "definitions.asm"

.intel_syntax noprefix

.globl crypt_xor
.globl crypt_xor_read
.globl crypt_xor_data
.globl crypt_xor_data_loop
.globl crypt_xor_data_loop_ret

#####################################
## Stack:
##	24  ->  data_buffer
##	20  ->  FD_OUT
##	16  ->  FD_IN
##	12  ->  key_buffer
##	8   ->  key_lengh
#####################################

.type crypt_xor, @function
crypt_xor:

	push ebp
	mov  ebp, esp

crypt_xor_read:

	# Read BLOCK_SIZE from Input
	push BLOCK_SIZE	
	push [ebp+24] 
	push [ebp+16]
	call file_read
	add esp, 12

	# Save Nr Chr which was readed
	push eax 		

	# XOR Key and readed Chars
	push [ebp+12]		
	push [ebp+8]
	push [ebp+24]
	push eax
	call crypt_xor_data
	add esp, 16

			
	# File Length from Stack
	# Ptr to data_buffer
	# FD_OUT
	push [ebp+24]			
	push [ebp+20]
	call file_write
	add esp, 8

	# Ger Nr Chr which was readed
	pop eax	

	# if BLOCK_SIZE = Read Size -> one more loop
	cmp eax, BLOCK_SIZE
	je crypt_xor_read

	mov  esp, ebp
	pop ebp

	ret


######################################
## Stack:
## 	20  ->  key_buffer
##      16  ->  key_length
##	12  ->  buffer
##	8   ->  buffer_length
######################################
##	edi -> Index of Key Position
##      esi -> Index of Buffer Position
######################################

.type crypt_xor_data, @function
crypt_xor_data:
	
	push ebp
	mov ebp, esp

	mov esi, 0
	mov edi, 0

crypt_xor_data_loop:

	mov ecx, [ebp+12]
	mov edx, [ebp+20]
	mov eax, [ecx+esi*4]
	xor eax, [edx+edi*4]
	mov [ecx+esi*4], eax

	inc esi

	# Compare Buffer Index to buffer_length
	cmp esi, [ebp+8]
	# if equal exit 		 
	je crypt_xor_data_loop_ret

	mov eax, [ebp+8]

	inc edi

	# Compary Key Index against key_length
	cmp edi, [ebp+16]
	jne crypt_xor_data_loop		 
				
	mov edi, 0
	
	jmp crypt_xor_data_loop


crypt_xor_data_loop_ret:
	mov esp, ebp
	pop ebp

	ret
	
