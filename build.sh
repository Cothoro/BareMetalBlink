#!/bin/bash
set -xe

mkdir -p build/

arm-none-eabi-as -mcpu=cortex-m4 -mthumb -o build/main.o main.s
arm-none-eabi-gcc -mcpu=cortex-m4 -mthumb -c -ffreestanding -o build/main_c.o main.c
arm-none-eabi-ld -nostdlib -T stm32f429.ld -o build/main.elf build/main.o build/main_c.o
arm-none-eabi-objcopy -O binary build/main.elf build/main.bin
