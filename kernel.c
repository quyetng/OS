/* kernel.c */
typedef unsigned short u16;
typedef unsigned int u32;

void kernel_main(void) {
    volatile unsigned short *video = (unsigned short*)0xB8000;
    const char *msg = "Hello, kernel! Welcome to your OS.";
    for (int i = 0; msg[i] != 0; ++i) {
        video[i] = (unsigned short) (msg[i] | (0x07 << 8)); /* char + attribute */
    }

    /* simple infinite loop */
    for (;;) { __asm__ __volatile__("hlt"); }
}
