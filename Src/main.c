#include "main.h"
#include <stdint.h>
#include "stm32l4xx.h"
#include "pins.h"

int main(void) {
    RCC->APB2ENR |= (1UL << 14U);
    RCC->AHB2ENR |= (1UL << 0U);

    // 4E6 MHz / 9600 Baud rounded up
    uint32_t usartDiv = 418UL;

    USART1->BRR = usartDiv;
    
    GPIOA->MODER &= ~(0x3UL << (TX_PIN * 2U));
    GPIOA->MODER |= (0x2UL << (TX_PIN * 2U));

    GPIOA->MODER &= ~(0x3UL << (RX_PIN * 2U));
    GPIOA->MODER |= (0x2UL << (RX_PIN * 2U));

    GPIOA->MODER &= ~(0x3UL << (TX_PIN * 2U));
    GPIOA->MODER &= ~(0x3UL << (RX_PIN * 2U));

    uint8_t txAfrIdx = TX_PIN >> 3U;
    uint8_t txBitShift = (TX_PIN & 0x7) * 4U;
    uint8_t rxAfrIdx = RX_PIN >> 3U;
    uint8_t rxBitShift = (RX_PIN & 0x7) * 4U;

    GPIOA->AFR[txAfrIdx] &= ~(0xFUL << txBitShift);
    GPIOA->AFR[rxAfrIdx] &= ~(0xFUL << txBitShift);

    GPIOA->AFR[txAfrIdx] |= (0x7UL << txBitShift);
    GPIOA->AFR[rxAfrIdx] |= (0x7UL << rxBitShift);

    USART1->CR1 |= (0x1UL << 2U);
    USART1->CR1 |= (0x1UL << 0U);
    USART1->CR1 |= (0x1UL << 3U);

    char rxd = '\0';
    while (1) {
        while(!(USART1->ISR & (0x1UL << 5U))) {}
        rxd = USART1->RDR;

        while(!(USART1->ISR & (0x1UL << 7U))) {}
        USART1->TDR = rxd;
        
    }

}