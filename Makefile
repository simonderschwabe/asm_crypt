default:
	./scripts/assemble.sh
	ld temp/*.o -o release/asm_crypt
