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
    USART1->CR1 |= (1UL << 3U);
    USART1->CR1 |= (1UL << 0U);

    GPIOA->MODER &= ~(0x3UL << (TX_PIN * 2U));
    GPIOA->MODER |= (0x2UL << (TX_PIN * 2U));

    GPIOA->MODER &= ~(0x3UL << (RX_PIN * 2U));
    GPIOA->MODER |= (0x2UL << (RX_PIN * 2U));

}