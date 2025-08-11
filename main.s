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

    ldr r1, =GPIOx_ODR

blink_loop:  
    @ Turn the LED on, finally
    ldr r2, [r1]
    orr r2, r2, #(1<<13)
    str r2, [r1]

    @ Crude delay
    ldr r0, =1000000
    bl crude_delay

    @ Turn the LED off.
    ldr r2, [r1]
    bic r2, r2, #(1<<13)
    str r2, [r1]

    @ Second crude delay
    ldr r0, =1000000
    bl crude_delay

    b blink_loop

@ r0 - number of cyles to delay execution
.thumb_func
crude_delay: 
    subs r0, r0, #1
    bne crude_delay
    bx lr
