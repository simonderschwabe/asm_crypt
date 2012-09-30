.include "definitions.asm"

.intel_syntax noprefix

.globl file_open
.globl file_read
.globl file_write
.globl file_close


.type file_open, @function
file_open:
	
	push ebp
	mov ebp, esp
	
	mov eax, SYS_OPEN
	mov ebx, [ebp+8]
	mov ecx, [ebp+12]
	mov edx, [ebp+16]
	int 0x80

	mov esp, ebp
	pop ebp

	ret

.type file_read, @function
file_read:

	push ebp
	mov ebp, esp

	mov eax, SYS_READ
	mov ebx, [ebp+8]	# File descriptor
	mov ecx, [ebp+12]	# Ptr to buffer
	mov edx, [ebp+16]	# Number of Bytes to Read
	int 0x80
				# Check eax != Number to Read -> EOF

	mov esp, ebp
	pop ebp

	ret
	

.type file_write, @function
file_write:

	push ebp
	mov ebp, esp

	mov eax, SYS_WRITE
	mov ebx, [ebp+8]	# File descriptor
	mov ecx, [ebp+12]	# Ptr to buffer
	mov edx, [ebp+16]	# Number of Bytes to write
	int 0x80
				# Check eax != Number of Write => Error

	mov esp, ebp
	pop ebp

	ret

.type file_close, @function
file_close:

	push ebp
	mov ebp, esp

	mov eax, SYS_CLOSE
	mov ebx, [ebp+8]
	int 0x80

	mov esp, ebp
	pop ebp

	ret

