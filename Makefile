default:
	mkdir temp
	mkdir release
	./scripts/assemble.sh
	ld temp/*.o -o release/asm_crypt
