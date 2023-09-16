const std = @import("std");
const MCU = @import("mcu.zig").MCU;
const GPIO = @import("gpio.zig").GPIO;
const device = @import("device.zig").device;
const cmsis = @import("cmsis.zig");

const UART_t = device.USART_Peripheral;

const RCC = device.RCC;

pub const UART = struct {
    mcu: MCU,
    instance: *volatile UART_t,
    baud: comptime_int,
    pins: GPIO,

    pub fn init(comptime uart: UART) void {
        uart.clock_enable(1);

        uart.instance.CR1.modify(.{
            .UE = 0,
            .RE = 1,
            .TE = 1,
            .RXNEIE = 0,
            .TCIE = 0,
            .TXEIE = 0,
            .PS = 0,
            .PCE = 0,
            .M1 = 0,
        });
        uart.instance.CR2.modify(.{
            .STOP = 0,
            .MSBFIRST = 0,
            .TXINV = 0,
            .RXINV = 0,
            .SWAP = 0,
            .CLKEN = 0,
            .LINEN = 0,
        });
        uart.instance.CR3.modify(.{
            .RTSE = 0,
            .CTSE = 0,
            .ONEBIT = 0,
            .SCEN = 0,
        });

        const pclk = uart.mcu.clk.get_pclk_hz();
        const baud = uart.baud;
        // Because its 16 bit sampling mode - we ignore the 4 bit mantissa.
        uart.instance.BRR.write_word((pclk + (baud / 2)) / baud);

        uart.pins.init_alternate(.push_pull, 0x04);

        uart.instance.CR1.modify(.{ .UE = 1 });
    }

    pub fn deinit(comptime uart: UART) void {
        uart.instance.CR1.write(.{ .UE = 0 });
        uart.clock_enable(0);
    }

    pub fn write(comptime uart: UART, data: []const u8) void {
        for (data) |b| {
            // Wait for TXE to be set - indicating there is room for another byte.
            while (uart.instance.ISR.read().TXE == 0) {
                cmsis.nop();
            }
            uart.instance.TDR.write_word(b);
        }
    }

    /// Enables the specified UART clock
    pub fn clock_enable(comptime uart: UART, comptime enable: u1) void {
        switch (uart.instance) {
            device.USART1 => RCC.APB2ENR.modify(.{ .USART1EN = enable }),
            device.USART2 => RCC.APB1ENR.modify(.{ .USART2EN = enable }),
            device.USART4 => RCC.APB1ENR.modify(.{ .USART4EN = enable }),
            device.USART5 => RCC.APB1ENR.modify(.{ .USART5EN = enable }),
            else => @compileError("The supplied UART has not been handled."),
        }
    }
};
