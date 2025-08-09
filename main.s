.syntax unified
.cpu cortex-m4
.thumb

.global _start

@ Data Registers
.equ RCC_AHB1ENR, 0x40023830
.equ GPIOx_MODER, 0x40021800 
.equ GPIOx_ODR,   0x40021814

# Vector Table
.section .isr_vector, "a", %progbits @ Reset Vector
.word 0x10010000                     @ Stack pointer at top of CCM
.word _start                         @ Reset Handler

.section .text
.thumb_func
_start:
    @ Enable the clock for GPIOG
    ldr r0, =RCC_AHB1ENR
    ldr r1, [r0]
    orr r1, r1, #(1<<6)
    str r1, [r0]

    @ Set PG13 to be an output
    ldr r0, =GPIOx_MODER
    ldr r1, [r0]
    bic r1, r1, #(0b11<<26)
    orr r1, r1, #(0b01<<26)
    str r1, [r0]

blink_loop:  
    @ Turn the LED on, finally
    ldr r0, =GPIOx_ODR
    ldr r1, [r0]
    orr r1, r1, #(1<<13)
    str r1, [r0]

    @ Crude delay
    mov r2, #0
delay_loop1:   
    adds r2, r2, #1
    ldr r3, =500000
    cmp r2, r3
    blt delay_loop1

    @ Turn the LED off.
    ldr r0, =GPIOx_ODR
    ldr r1, [r0]
    bic r1, r1, #(1<<13)
    str r1, [r0]

    @ Second crude delay
    mov r2, #0
delay_loop2:   
    adds r2, r2, #1
    ldr r3, =500000
    cmp r2, r3
    blt delay_loop2

    b blink_loop
