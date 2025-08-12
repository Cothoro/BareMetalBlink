#define RCC_AHB1ENR 0x40023830
#define GPIOx_MODER 0x40021800
#define GPIOx_ODR   0x40021814

#define uint unsigned int

#define REG_UINT32(addr) (*(volatile uint*)(addr))

void crude_wait(uint iters)
{
    while (iters)
        iters--;
    return;
}

void main(void)
{
    REG_UINT32(RCC_AHB1ENR) |= (1 << 6);
    
    REG_UINT32(GPIOx_MODER) &= ~(0b01 << 26);
    REG_UINT32(GPIOx_MODER) |=  (0b01 << 26);
    
    for (;;) {
        REG_UINT32(GPIOx_ODR) ^= (1 << 13);
        crude_wait(500000);
    }
    
    return;
}
