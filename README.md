# Description

asm_crypt is a open source encryption tool which is written in 
assembly. The focus of the tool is to provide fast encryption without
overhead. This means the encryption is almost as fast as your disks.
One benefit is, that you could use anything as Keyfile, binaries, textfiles 
and so on. Please keep in mind: Currently no warrenty can be given that it is
mathematicaly secure.

Have fun.

# Basic Functionality

	Input XOR Key -> Output

# Supported Architectures

Currently supported OS:

	linux - i686

# Requirements

Required Software:

	[Gnu Assembler] 
	[Gnu ld]
	[Gnu make]

# Install

Execute:

```bash
make
```

# How to run

Execute:

```bash
./asm_crypt <KeyFile> <InputFile> <OutputFile>
```
