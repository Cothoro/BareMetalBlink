.syntax unified
.cpu cortex-m4
.thumb

.global _start

.extern main

@ Vector Table
.section .isr_vector, "a", %progbits @ Reset Vector
.word 0x10010000                     @ Stack pointer at top of CCM
.word main                           @ Reset Handler
