/* link.ld — linker script for multiboot kernel */
ENTRY(_start)

SECTIONS
{
    . = 1M;

    .multiboot : { *(.multiboot) }
    .text      : { *(.text)      }
    .rodata    : { *(.rodata)    }
    .data      : { *(.data)      }
    .bss       : { *(.bss)       }
}
