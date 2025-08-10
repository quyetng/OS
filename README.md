1. 
Install packages
qemu-system-i386, grub-pc-bin / grub2-common (for grub-mkrescue), and a cross-compiler i686-elf-gcc. If you don’t have a cross-compiler you can try system gcc -m32 but cross is recommended

2. 
make
qemu-system-i386 -cdrom os.iso