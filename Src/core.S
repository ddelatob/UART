.syntax unified
.cpu cortex-m4
.fpu fpv4-sp-d16
.thumb

.global vtable
.global default_interrupt_handler
.global reset_handler

.type reset_handler, %function
reset_handler:
	LDR r0, =_estack
	MOV sp, r0
	MOVS r0, #0
	LDR r1, =_sdata
	LDR r2, =_edata
	LDR r3, =_sidata
	B copy_sidata_loop

	copy_sidata:
		LDR r4, [r3, r0]
		STR r4, [r1, r0]
		ADDS r0, r0, #4

	copy_sidata_loop:
		ADDS r4, r0, r1
		CMP r4, r2
		BCC copy_sidata

	MOVS r0, #0
	LDR r1, =_sbss
	LDR r2, =_ebss
	B reset_bss_loop

	reset_bss:
		STR r0, [r1]
		ADDS r1, r1, #4

	reset_bss_loop:
		CMP r1, r2
		BCC reset_bss
		B main
.size reset_handler, .-reset_handler

.section .vector_table, "a", %progbits
.type vtable, %object
vtable:
	.word	_estack
	.word	reset_handler
	.word	NMI_Handler
	.word	HardFault_Handler
	.word	MemManage_Handler
	.word	BusFault_Handler
	.word	UsageFault_Handler
	.word	0
	.word	0
	.word	0
	.word	0
	.word	SVC_Handler
	.word	DebugMon_Handler
	.word	0
	.word	PendSV_Handler
	.word	SysTick_Handler
	.word	WWDG_IRQHandler
	.word	PVD_PVM_IRQHandler
	.word	TAMP_STAMP_IRQHandler
	.word	RTC_WKUP_IRQHandler
	.word	FLASH_IRQHandler
	.word	RCC_IRQHandler
	.word	EXTI0_IRQHandler
	.word	EXTI1_IRQHandler
	.word	EXTI2_IRQHandler
	.word	EXTI3_IRQHandler
	.word	EXTI4_IRQHandler
	.word	DMA1_Channel1_IRQHandler
	.word	DMA1_Channel2_IRQHandler
	.word	DMA1_Channel3_IRQHandler
	.word	DMA1_Channel4_IRQHandler
	.word	DMA1_Channel5_IRQHandler
	.word	DMA1_Channel6_IRQHandler
	.word	DMA1_Channel7_IRQHandler
	.word	ADC1_IRQHandler
	.word	CAN1_TX_IRQHandler
	.word	CAN1_RX0_IRQHandler
	.word	CAN1_RX1_IRQHandler
	.word	CAN1_SCE_IRQHandler
	.word	EXTI9_5_IRQHandler
	.word	TIM1_BRK_TIM15_IRQHandler
	.word	TIM1_UP_TIM16_IRQHandler
	.word	TIM1_TRG_COM_IRQHandler
	.word	TIM1_CC_IRQHandler
	.word	TIM2_IRQHandler
	.word	0
	.word	0
	.word	I2C1_EV_IRQHandler
	.word	I2C1_ER_IRQHandler
	.word	0
	.word	0
	.word	SPI1_IRQHandler
	.word	0
	.word	USART1_IRQHandler
	.word	USART2_IRQHandler
	.word	0
	.word	EXTI15_10_IRQHandler
	.word	RTC_Alarm_IRQHandler
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	0
	.word	SPI3_IRQHandler
	.word	0
	.word	0
	.word	TIM6_DAC_IRQHandler
	.word	TIM7_IRQHandler
	.word	DMA2_Channel1_IRQHandler
	.word	DMA2_Channel2_IRQHandler
	.word	DMA2_Channel3_IRQHandler
	.word	DMA2_Channel4_IRQHandler
	.word	DMA2_Channel5_IRQHandler
	.word	0
	.word	0
	.word	0
	.word	COMP_IRQHandler
	.word	LPTIM1_IRQHandler
	.word	LPTIM2_IRQHandler
	.word	USB_IRQHandler
	.word	DMA2_Channel6_IRQHandler
	.word	DMA2_Channel7_IRQHandler
	.word	LPUART1_IRQHandler
	.word	QUADSPI_IRQHandler
	.word	I2C3_EV_IRQHandler
	.word	I2C3_ER_IRQHandler
	.word	SAI1_IRQHandler
	.word	0
	.word	SWPMI1_IRQHandler
	.word	TSC_IRQHandler
	.word	0
	.word	0
	.word	RNG_IRQHandler
	.word	FPU_IRQHandler
	.word	CRS_IRQHandler

	.weak	NMI_Handler
		.thumb_set NMI_Handler,default_interrupt_handler

	.weak	HardFault_Handler
		.thumb_set HardFault_Handler,default_interrupt_handler

  	.weak	MemManage_Handler
		.thumb_set MemManage_Handler,default_interrupt_handler

  	.weak	BusFault_Handler
		.thumb_set BusFault_Handler,default_interrupt_handler

	.weak	UsageFault_Handler
		.thumb_set UsageFault_Handler,default_interrupt_handler

	.weak	SVC_Handler
		.thumb_set SVC_Handler,default_interrupt_handler

	.weak	DebugMon_Handler
		.thumb_set DebugMon_Handler,default_interrupt_handler

	.weak	PendSV_Handler
		.thumb_set PendSV_Handler,default_interrupt_handler

	.weak	SysTick_Handler
		.thumb_set SysTick_Handler,default_interrupt_handler

	.weak	WWDG_IRQHandler
		.thumb_set WWDG_IRQHandler,default_interrupt_handler

	.weak	PVD_PVM_IRQHandler
		.thumb_set PVD_PVM_IRQHandler,default_interrupt_handler

	.weak	TAMP_STAMP_IRQHandler
		.thumb_set TAMP_STAMP_IRQHandler,default_interrupt_handler

	.weak	RTC_WKUP_IRQHandler
		.thumb_set RTC_WKUP_IRQHandler,default_interrupt_handler

	.weak	FLASH_IRQHandler
		.thumb_set FLASH_IRQHandler,default_interrupt_handler

	.weak	RCC_IRQHandler
		.thumb_set RCC_IRQHandler,default_interrupt_handler

	.weak	EXTI0_IRQHandler
		.thumb_set EXTI0_IRQHandler,default_interrupt_handler

	.weak	EXTI1_IRQHandler
		.thumb_set EXTI1_IRQHandler,default_interrupt_handler

	.weak	EXTI2_IRQHandler
		.thumb_set EXTI2_IRQHandler,default_interrupt_handler

	.weak	EXTI3_IRQHandler
		.thumb_set EXTI3_IRQHandler,default_interrupt_handler

	.weak	EXTI4_IRQHandler
		.thumb_set EXTI4_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel1_IRQHandler
		.thumb_set DMA1_Channel1_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel2_IRQHandler
		.thumb_set DMA1_Channel2_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel3_IRQHandler
		.thumb_set DMA1_Channel3_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel4_IRQHandler
		.thumb_set DMA1_Channel4_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel5_IRQHandler
		.thumb_set DMA1_Channel5_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel6_IRQHandler
		.thumb_set DMA1_Channel6_IRQHandler,default_interrupt_handler

	.weak	DMA1_Channel7_IRQHandler
		.thumb_set DMA1_Channel7_IRQHandler,default_interrupt_handler

	.weak	ADC1_IRQHandler
		.thumb_set ADC1_IRQHandler,default_interrupt_handler

	.weak	CAN1_TX_IRQHandler
		.thumb_set CAN1_TX_IRQHandler,default_interrupt_handler

	.weak	CAN1_RX0_IRQHandler
		.thumb_set CAN1_RX0_IRQHandler,default_interrupt_handler

	.weak	CAN1_RX1_IRQHandler
		.thumb_set CAN1_RX1_IRQHandler,default_interrupt_handler

	.weak	CAN1_SCE_IRQHandler
		.thumb_set CAN1_SCE_IRQHandler,default_interrupt_handler

	.weak	EXTI9_5_IRQHandler
		.thumb_set EXTI9_5_IRQHandler,default_interrupt_handler

	.weak	TIM1_BRK_TIM15_IRQHandler
		.thumb_set TIM1_BRK_TIM15_IRQHandler,default_interrupt_handler

	.weak	TIM1_UP_TIM16_IRQHandler
		.thumb_set TIM1_UP_TIM16_IRQHandler,default_interrupt_handler

	.weak	TIM1_TRG_COM_IRQHandler
		.thumb_set TIM1_TRG_COM_IRQHandler,default_interrupt_handler

	.weak	TIM1_CC_IRQHandler
		.thumb_set TIM1_CC_IRQHandler,default_interrupt_handler

	.weak	TIM2_IRQHandler
		.thumb_set TIM2_IRQHandler,default_interrupt_handler

	.weak	I2C1_EV_IRQHandler
		.thumb_set I2C1_EV_IRQHandler,default_interrupt_handler

	.weak	I2C1_ER_IRQHandler
		.thumb_set I2C1_ER_IRQHandler,default_interrupt_handler

	.weak	SPI1_IRQHandler
		.thumb_set SPI1_IRQHandler,default_interrupt_handler

	.weak	USART1_IRQHandler
		.thumb_set USART1_IRQHandler,default_interrupt_handler

	.weak	USART2_IRQHandler
		.thumb_set USART2_IRQHandler,default_interrupt_handler

	.weak	EXTI15_10_IRQHandler
		.thumb_set EXTI15_10_IRQHandler,default_interrupt_handler

	.weak	RTC_Alarm_IRQHandler
		.thumb_set RTC_Alarm_IRQHandler,default_interrupt_handler

	.weak	SPI3_IRQHandler
		.thumb_set SPI3_IRQHandler,default_interrupt_handler

	.weak	TIM6_DAC_IRQHandler
		.thumb_set TIM6_DAC_IRQHandler,default_interrupt_handler

	.weak	TIM7_IRQHandler
		.thumb_set TIM7_IRQHandler,default_interrupt_handler

	.weak	DMA2_Channel1_IRQHandler
		.thumb_set DMA2_Channel1_IRQHandler,default_interrupt_handler

	.weak	DMA2_Channel2_IRQHandler
		.thumb_set DMA2_Channel2_IRQHandler,default_interrupt_handler

	.weak	DMA2_Channel3_IRQHandler
		.thumb_set DMA2_Channel3_IRQHandler,default_interrupt_handler

	.weak	DMA2_Channel4_IRQHandler
		.thumb_set DMA2_Channel4_IRQHandler,default_interrupt_handler

	.weak	DMA2_Channel5_IRQHandler
		.thumb_set DMA2_Channel5_IRQHandler,default_interrupt_handler

	.weak	COMP_IRQHandler
		.thumb_set COMP_IRQHandler,default_interrupt_handler
	
	.weak	LPTIM1_IRQHandler
		.thumb_set LPTIM1_IRQHandler,default_interrupt_handler
	
	.weak	LPTIM2_IRQHandler
		.thumb_set LPTIM2_IRQHandler,default_interrupt_handler	
	
	.weak	USB_IRQHandler
		.thumb_set USB_IRQHandler,default_interrupt_handler	
	
	.weak	DMA2_Channel6_IRQHandler
		.thumb_set DMA2_Channel6_IRQHandler,default_interrupt_handler	
	
	.weak	DMA2_Channel7_IRQHandler
		.thumb_set DMA2_Channel7_IRQHandler,default_interrupt_handler	
	
	.weak	LPUART1_IRQHandler
		.thumb_set LPUART1_IRQHandler,default_interrupt_handler	
	
	.weak	QUADSPI_IRQHandler
		.thumb_set QUADSPI_IRQHandler,default_interrupt_handler	
	
	.weak	I2C3_EV_IRQHandler
		.thumb_set I2C3_EV_IRQHandler,default_interrupt_handler	
	
	.weak	I2C3_ER_IRQHandler
		.thumb_set I2C3_ER_IRQHandler,default_interrupt_handler	
	
	.weak	SAI1_IRQHandler
		.thumb_set SAI1_IRQHandler,default_interrupt_handler
	
	.weak	SWPMI1_IRQHandler
		.thumb_set SWPMI1_IRQHandler,default_interrupt_handler
	
	.weak	TSC_IRQHandler
		.thumb_set TSC_IRQHandler,default_interrupt_handler
	
	.weak	RNG_IRQHandler
		.thumb_set RNG_IRQHandler,default_interrupt_handler
	
	.weak	FPU_IRQHandler
		.thumb_set FPU_IRQHandler,default_interrupt_handler
	
	.weak	CRS_IRQHandler
		.thumb_set CRS_IRQHandler,default_interrupt_handler
.size vtable, .-vtable


.section .text.default_interrupt_handler, "ax", %progbits
.type default_interrupt_handler, %function
default_interrupt_handler:
    default_interrupt_loop:
        B default_interrupt_loop
.size default_interrupt_handler, .-default_interrupt_handler