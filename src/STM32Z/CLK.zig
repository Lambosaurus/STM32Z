const std = @import("std");
const mcu = @import("mcu.zig").mcu;

const RCC = mcu.RCC;

const HSI_FREQ_HZ = 16_000_000;

/// Configures the clock tree.
/// No need to create this directly - this will be initialized by the CORE module.
pub const CLK = struct {
    core_hz: comptime_int,
    hse_hz: comptime_int,

    pub fn new(comptime core_hz: comptime_int) CLK {
        return .{
            .core_hz = core_hz,
        };
    }

    pub fn init(comptime clk: CLK) void {
        if (clk.core_hz == HSI_FREQ_HZ) {
            enable_hsi();
        }
    }
};

fn enable_hsi() void {
    RCC.CFGR.modify(.{ .HSI16ON = 1 });
    while (RCC.CFGR.read().HSI16RDYF == 0) {}
}

//void CLK_InitSYSCLK(void)
// {
// 	__HAL_FLASH_SET_LATENCY(FLASH_LATENCY);
// #ifdef CLK_WAKEUP_CLK
// 	__HAL_RCC_WAKEUPSTOP_CLK_CONFIG(CLK_WAKEUP_CLK);
// #endif

// 	/*
// 	 * ENABLE OSCILLATORS
// 	 * Enable any required oscillators
// 	 */

// #ifdef CLK_USE_HSE
// #ifdef CLK_HSE_BYPASS
// 	__HAL_RCC_HSE_CONFIG(RCC_HSE_BYPASS_PWR);
// #else
// 	__HAL_RCC_HSE_CONFIG(RCC_HSE_ON);
// #endif
// 	while(__HAL_RCC_GET_FLAG(RCC_FLAG_HSERDY) == 0U);
// #endif
// #ifdef CLK_USE_HSI
// 	__HAL_RCC_HSI_CALIBRATIONVALUE_ADJUST(RCC_HSICALIBRATION_DEFAULT);
// 	__HAL_RCC_HSI_ENABLE();
// 	while(__HAL_RCC_GET_FLAG(RCC_FLAG_HSIRDY) == 0U);
// #endif
// #ifdef CLK_USE_MSI
// 	__HAL_RCC_MSI_ENABLE();
// 	while(__HAL_RCC_GET_FLAG(RCC_FLAG_MSIRDY) == 0U);
// 	__HAL_RCC_MSI_RANGE_CONFIG(CLK_MSI_RANGE);
// 	__HAL_RCC_MSI_CALIBRATIONVALUE_ADJUST(RCC_MSICALIBRATION_DEFAULT);
// #endif

// #ifdef CLK_USE_PLL
// 	// PLL must be disables for configuration.
// 	__HAL_RCC_PLL_DISABLE();
// 	while(__HAL_RCC_GET_FLAG(RCC_FLAG_PLLRDY) != 0U);
// 	__CLK_PLL_CONFIG(CLK_PLL_SRC, CLK_PLL_MUL_CFG, CLK_PLL_DIV_CFG);
// 	__HAL_RCC_PLL_ENABLE();
// #if defined(STM32G0) || defined(STM32WL)
// 	__HAL_RCC_PLLCLKOUT_ENABLE(RCC_PLL_SYSCLK);
// #endif
// 	while(__HAL_RCC_GET_FLAG(RCC_FLAG_PLLRDY) == 0U);
// #endif

// 	/*
// 	 * CONFIGURE CLOCKS
// 	 * Select the sources and dividers for internal clocks
// 	 */

// 	// Configure AHBCLK divider
// 	MODIFY_REG(RCC->CFGR, RCC_CFGR_HPRE, RCC_SYSCLK_DIV1);

// 	// Apply SYSCLK source
// 	__HAL_RCC_SYSCLK_CONFIG(CLK_SYSCLK_SRC);
// #if ( defined(RCC_SYSCLKSOURCE_MSI) && CLK_SYSCLK_SRC == RCC_SYSCLKSOURCE_MSI)
// 	while (__HAL_RCC_GET_SYSCLK_SOURCE() != RCC_SYSCLKSOURCE_STATUS_MSI);
// #elif (CLK_SYSCLK_SRC == RCC_SYSCLKSOURCE_HSI)
// 	while (__HAL_RCC_GET_SYSCLK_SOURCE() != RCC_SYSCLKSOURCE_STATUS_HSI);
// #elif (CLK_SYSCLK_SRC == RCC_SYSCLKSOURCE_HSE)
// 	while (__HAL_RCC_GET_SYSCLK_SOURCE() != RCC_SYSCLKSOURCE_STATUS_HSE);
// #elif (CLK_SYSCLK_SRC == RCC_SYSCLKSOURCE_PLLCLK)
// 	while (__HAL_RCC_GET_SYSCLK_SOURCE() != RCC_SYSCLKSOURCE_STATUS_PLLCLK);
// #endif

// 	// Configure PCLK dividers (peripheral clock)

// #if defined(STM32L0) || defined(STM32WL) || defined(STM32G0)
// 	// STM32L0's have a second PCLK. The shift by 3 is defined like this in the HAL.
// 	MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE1, RCC_HCLK_DIV1);
// 	MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE2, RCC_HCLK_DIV1 << 3);
// #elif defined(STM32F0)
// 	MODIFY_REG(RCC->CFGR, RCC_CFGR_PPRE, RCC_HCLK_DIV1);
// #endif

// 	/*
// 	 * DISABLE OSCILLATORS
// 	 * Unused oscillators should be turned off.
// 	 * Note they are disabled AFTER sysclk source is redirected
// 	 */

// #ifndef CLK_USE_HSI
// 	__HAL_RCC_HSI_DISABLE();
// #endif
// #if (defined(RCC_SYSCLKSOURCE_MSI) && !defined(CLK_USE_MSI))
// 	__HAL_RCC_MSI_DISABLE();
// #endif
// }
