/* boot.s - multiboot header + entry */
.section .multiboot
.align 4
/* multiboot magic, flags, checksum */
.long 0x1BADB002
.long 0x00010003
.long -(0x1BADB002 + 0x00010003)

.section .text
.global start
.global _start

/* stack (4KB) */
.bss
.comm stack, 4096
.set STACK_TOP, stack + 4096

.text
start:
    cli
    /* set up segments to 0 */
    xorw %ax, %ax
    movw %ax, %ds
    movw %ax, %es
    movw %ax, %fs
    movw %ax, %gs
    movw %ax, %ss

    /* set stack */
    movl $STACK_TOP, %esp

    /* call C kernel entry */
    call kernel_main

halt:
    hlt
    jmp halt
