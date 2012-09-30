.include "definitions.asm"

.intel_syntax noprefix

.globl argv_number

#####################################
## Returns number of Arguments
#####################################
.type argv_number, @function
argv_number:

	mov ebp, esp
	mov eax, 4
	mov edi, 0

argv_number_loop:

	add eax, 4
	mov ebx, [ebp+eax]

	# End if 128 Parameters are reached
	cmp edi, 128
	je argv_end

	# Test Address in ebx for Null Pointer	
	test ebx, ebx	
	jz argv_end

argv_counter:
	
	inc edi		

	jmp argv_number_loop

argv_end:

	mov eax, edi

	ret

	
