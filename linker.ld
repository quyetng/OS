/* linker.ld */
ENTRY(start)

SECTIONS
{
  /* place the kernel at 1MB (0x00100000) */
  . = 0x00100000;

  .text :
  {
    *(.multiboot)
    *(.text)
    *(.rodata)
  }

  .data :
  {
    *(.data)
  }

  .bss :
  {
    *(.bss)
    *(COMMON)
    . = ALIGN(4);
  }
}
