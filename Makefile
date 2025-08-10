# Makefile (uses i686-elf GCC cross-toolchain)
CC=i686-elf-gcc
LD=i686-elf-ld
AS=i686-elf-as
OBJCOPY=i686-elf-objcopy
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -fno-stack-protector -m32
LDFLAGS = -nostdlib -T linker.ld

all: os.iso

kernel.bin: boot.o kernel.o
	$(LD) $(LDFLAGS) -o kernel.elf boot.o kernel.o
	$(OBJCOPY) -O binary kernel.elf kernel.bin

boot.o: boot.s
	$(AS) --32 boot.s -o boot.o

kernel.o: kernel.c
	$(CC) $(CFLAGS) -c kernel.c -o kernel.o

iso/boot/grub/grub.cfg: kernel.bin
	mkdir -p iso/boot/grub
	cp kernel.bin iso/boot/kernel.bin
	cp -v grub.cfg iso/boot/grub/grub.cfg

os.iso: kernel.bin iso/boot/grub/grub.cfg
	grub-mkrescue -o os.iso iso

clean:
	rm -rf *.o *.elf *.bin iso os.iso
