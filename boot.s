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

.bss
.align 16
stack:
    .skip 4096              # allocate 4KB for stack
stack_top:

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

    /* set stack pointer */
    movl $stack_top, %esp

    /* call C kernel entry */
    call kernel_main

halt:
    hlt
    jmp halt
