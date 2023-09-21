const regs = @import("device.zig").regs;
const gpio = @import("gpio.zig");
const cmsis = @import("cmsis.zig");
const clock = @import("clock.zig");

const Instance = regs.USART_Peripheral;
const RCC = regs.RCC;

pub const Parity = enum {
    none,
    even,
    odd,
};

pub const BitOrder = enum {
    msb_first,
    lsb_first,
};

pub const Config = struct {
    baud: comptime_int,
    pins: gpio.Pin,
    data_bits: comptime_int = 8,
    parity: Parity = .none,
    invert: bool = false,
    swap_txrx: bool = false,
    order: BitOrder = .lsb_first,
};

pub fn new(instance: *volatile Instance) UART {
    return .{ .instance = instance };
}

pub const UART = struct {
    instance: *volatile Instance,
    pins: gpio.Pin = undefined,

    pub fn init(uart: *UART, comptime config: Config) void {
        uart.pins = config.pins;
        uart.clock_enable(1);

        // The data bit configuration includes the parity bit.
        const data_bits = config.data_bits + (if (config.parity == .none) 0 else 1);

        uart.instance.CR1.modify(.{
            .UE = 0,
            .RE = 1,
            .TE = 1,
            .RXNEIE = 0,
            .TCIE = 0,
            .TXEIE = 0,
            .PS = @intFromBool(config.parity == .odd),
            .PCE = @intFromBool(config.parity != .none),
            .M1 = switch (data_bits) {
                7 => 2,
                8 => 0,
                9 => 1,
                else => @compileError("Number of data bits not supported"),
            },
        });
        uart.instance.CR2.modify(.{
            .STOP = 0,
            .MSBFIRST = @intFromBool(config.order == .msb_first),
            .TXINV = @intFromBool(config.invert),
            .RXINV = @intFromBool(config.invert),
            .SWAP = @intFromBool(config.swap_txrx),
            .CLKEN = 0,
            .LINEN = 0,
        });
        uart.instance.CR3.modify(.{
            .RTSE = 0,
            .CTSE = 0,
            .ONEBIT = 0,
            .SCEN = 0,
        });

        const pclk = clock.get_pclk_hz();
        const baud = config.baud;
        // Because its 16 bit sampling mode - we ignore the 4 bit mantissa.
        uart.instance.BRR.write_word((pclk + (baud / 2)) / baud);

        config.pins.init_alternate(.push_pull, .usart1);

        uart.instance.CR1.modify(.{ .UE = 1 });
    }

    pub fn deinit(uart: *UART) void {
        uart.instance.CR1.write(.{ .UE = 0 });
        uart.clock_enable(0);
        uart.pins.deinit();
    }

    pub fn write(uart: *UART, data: []const u8) void {
        for (data) |b| {
            // Wait for TXE to be set - indicating there is room for another byte.
            while (uart.instance.ISR.read().TXE == 0) {
                cmsis.nop();
            }
            uart.instance.TDR.write_word(b);
        }
    }

    /// Enables the specified UART clock
    fn clock_enable(uart: *UART, enable: u1) void {
        switch (uart.instance) {
            regs.USART1 => RCC.APB2ENR.modify(.{ .USART1EN = enable }),
            regs.USART2 => RCC.APB1ENR.modify(.{ .USART2EN = enable }),
            //regs.USART3 => RCC.APB2ENR.modify(.{ .USART3EN = enable }),
            regs.USART4 => RCC.APB1ENR.modify(.{ .USART4EN = enable }),
            regs.USART5 => RCC.APB1ENR.modify(.{ .USART5EN = enable }),
            //else => @compileError("The supplied UART has not been handled."),
            else => {},
        }
    }
};
