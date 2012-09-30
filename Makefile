default:
	mkdir -p temp
	mkdir -p release
	./scripts/assemble.sh
	ld temp/*.o -o release/asm_crypt
