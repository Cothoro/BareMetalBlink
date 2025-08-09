ENTRY(_start)

MEMORY {
       flash (rx) : ORIGIN = 0x08000000, LENGTH = 2M
       ccm (rwx) : ORIGIN = 0x10000000, LENGTH = 64K
}

_estack = ORIGIN(ccm) + LENGTH(ccm); /* Useful for tooling */

SECTIONS {
         .isr_vector ORIGIN(flash) :
         {
            KEEP(*(.isr_vector))  
         } > flash

         .text :
         {
            *(.text*) *(.rodata*)
         } > flash
}
