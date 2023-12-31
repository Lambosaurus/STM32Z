pub const main = @import("main.zig");

// These symbols come from the linker script
extern const _data_loadaddr: u32;
extern const _data: u32;
extern const _edata: u32;
extern const _bss: u32;
extern const _ebss: u32;
// Stack pointer is also a u32, but we lie to get it into the vector.
extern fn _estack() void;

export fn resetHandler() void {
    // Copy data from flash to RAM
    const data_loadaddr: [*]const u8 = @ptrCast(&_data_loadaddr);
    const data: [*]u8 = @ptrCast(&_data);
    const data_size: u32 = @intFromPtr(&_edata) - @intFromPtr(&_data);
    for (data_loadaddr[0..data_size], 0..) |d, i| {
        data[i] = d;
    }

    // Clear the bss
    const bss = @as([*]u8, @ptrCast(&_bss));
    const bss_size = @intFromPtr(&_ebss) - @intFromPtr(&_bss);
    for (bss[0..bss_size]) |*b| {
        b.* = 0;
    }

    // Call contained in main.zig
    main.main();
}

export fn defaultHandler() void {
    while (true) {}
}

extern fn systemTickHandler() void;

// The ISR vector table.
export const vector_table linksection(".vector") = [_](*const fn () callconv(.C) void){
    _estack, // Stack pointer
    resetHandler, // Reset handler (entry point)
    defaultHandler, // NMI Handler
    defaultHandler, // Hardfault Handler
    defaultHandler, // Reserved 1
    defaultHandler, // Reserved 2
    defaultHandler, // Reserved 3
    defaultHandler, // Reserved 4
    defaultHandler, // Reserved 5
    defaultHandler, // Reserved 6
    defaultHandler, // Reserved 7
    defaultHandler, // SVC Handler
    defaultHandler, // Reserved 8
    defaultHandler, // Reserved 9
    defaultHandler, // Pend SV Handler
    @import("stm32z/mcu.zig").systemTickHandler, // System Tick
    defaultHandler, // WWDG
    defaultHandler, // PVD
    defaultHandler, // RTC
    defaultHandler, // FLASH
    defaultHandler, // RCC / CRS
    defaultHandler, // EXTI 0:1
    defaultHandler, // EXTI 2:3
    defaultHandler, // EXTI 14:15
    defaultHandler, // Reserved 10
    defaultHandler, // DMA1 CH 1
    defaultHandler, // DMA1 CH 2:3
    defaultHandler, // DMA1 CH 4:7
    defaultHandler, // ADC / COMP
    defaultHandler, // LPTIM1
    defaultHandler, // UART4 / UART5
    defaultHandler, // TIM2
    defaultHandler, // TIM3
    defaultHandler, // TIM6
    defaultHandler, // TIM7
    defaultHandler, // Reserved 11
    defaultHandler, // TIM21
    defaultHandler, // I2C3
    defaultHandler, // TIM22
    defaultHandler, // I2C1
    defaultHandler, // I2C2
    defaultHandler, // SPI1
    defaultHandler, // SPI2
    @import("stm32z/uart.zig").uart1Handler, // UART1
    defaultHandler, // UART2
    defaultHandler, // LPUART1 / AES
};
