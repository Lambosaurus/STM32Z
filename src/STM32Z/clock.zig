const std = @import("std");
const cmsis = @import("cmsis.zig");
const device = @import("device.zig");
const regs = device.regs;

/// Global clock configuration object
const config: ClockConfig = device.config.clock;

const RCC = regs.RCC;

const HSI_FREQ = 16_000_000;
const MSI_FREQ_MIN = 65_536;
const MSI_FREQ_MAX = 4_194_304;

const PLL_MUL_FACTORS = .{ 3, 4, 6, 8, 12, 16, 24, 32, 48 };
//PLLDIV = 0 is invalid.
const PLL_DIV_FACTORS = .{ 0, 2, 3, 4 };

const ClockSource = enum(u2) {
    // Medium speed internal oscillator.
    msi = 0,
    // High speed internal oscillator.
    hsi = 1,
    // High speed external oscillator.
    hse = 2,
    // Phased lock loop.
    // Do not select the PLL as a clock source. It will be automatically done if needed.
    pll = 3,
};

/// Configuration object. This should be available
pub const ClockConfig = struct {
    sysclk_hz: comptime_int = 32_000_000,
    clock_source: ClockSource = .hsi,
    hse_hz: ?comptime_int = null,
};

/// Inititialises the system clocks.
/// No need to do this directly. Let the MCU object do this.
pub fn init() void {
    flash_set_latency(config.sysclk_hz);

    comptime var input_hz: comptime_int = undefined;

    switch (config.clock_source) {
        .msi => {
            msi_enable(1);
            msi_set_speed(config.sysclk_hz);
            input_hz = config.sysclk_hz;
        },
        .hsi => {
            hsi_enable(1);
            input_hz = HSI_FREQ;
        },
        .hse => {
            hse_enable(1);
            if (config.hse_hz == null) {
                @compileError("Please specify the HSE frequency.");
            }
            input_hz = config.hse_hz.?;
        },
        .pll => @compileError("Please select the root clock. The PLL will be enabled if needed."),
    }

    if (input_hz == config.sysclk_hz) {
        // PLL not needed. Run directly from input source
        sysclk_set_src(config.clock_source);
    } else {
        // PLL is needed. Do the thing.
        pll_configure(config.clock_source, input_hz, config.sysclk_hz);
        sysclk_set_src(.pll);
    }

    configure_bus_clocks();

    if (config.clock_source != .msi) {
        // The MSI is the default clock source. It is no longer needed.
        msi_enable(0);
    }
}

pub fn get_sysclk_hz() comptime_int {
    return config.sysclk_hz;
}

pub fn get_pclk_hz() comptime_int {
    return config.sysclk_hz;
}

fn flash_set_latency(comptime sysclk_hz: comptime_int) void {
    const state: u1 = if (sysclk_hz > 16_000_000) 1 else 0;
    regs.FLASH.ACR.modify(.{
        .LATENCY = state,
    });
}

/// Enable the High Speed Internal oscillator (HSI).
fn hsi_enable(comptime enable: u1) void {
    RCC.CR.modify(.{ .HSI16ON = enable });
    if (enable == 1) {
        // Do not wait for disable.
        while (RCC.CR.read().HSI16RDYF == 0) {
            cmsis.nop();
        }
    }
}

/// Enable the Medium Speed Internal oscillator (MSI).
fn msi_enable(comptime enable: u1) void {
    RCC.CR.modify(.{ .MSION = enable });
    if (enable == 1) {
        // Do not wait for disable.
        while (RCC.CR.read().MSIRDY == 0) {
            cmsis.nop();
        }
    }
}

// Configure the speed range of the MSI.
fn msi_set_speed(comptime target_speed: comptime_int) void {
    _ = target_speed;
    @compileError("The MSI speed range has not been implemented yet.");
}

/// Enable the High Speed External oscillator (HSE).
fn hse_enable(comptime enable: u1) void {
    RCC.CR.modify(.{ .HSEON = enable });
    if (enable == 1) {
        // Do not wait for disable.
        while (RCC.CR.read().HSERDY == 0) {
            cmsis.nop();
        }
    }
}

/// Enable the Phased Locked Loop (PLL).
fn pll_enable(comptime enable: u1) void {
    RCC.CR.modify(.{ .PLLON = enable });
    // Always wait for PLL to enable/disable.
    // It must be disabled prior to configuration.
    while (RCC.CR.read().PLLRDY != enable) {
        cmsis.nop();
    }
}

// Configures the PLL with the selected settings.
fn pll_configure(comptime src: ClockSource, comptime input_hz: comptime_int, comptime target_hz: comptime_int) void {
    pll_enable(0);

    comptime var pll_src: comptime_int = undefined;
    comptime var pll_mul: comptime_int = undefined;
    comptime var pll_div: comptime_int = undefined;

    comptime {
        pll_src = switch (src) {
            .hsi => 0,
            .hse => 1,
            else => @compileError("Invalid PLL input."),
        };

        // Find a mul/div solution that works.
        // Very caveman solution - but no reason to be any more complex.
        pll_selection: for (PLL_MUL_FACTORS, 0..) |multiplier, m| {
            for (PLL_DIV_FACTORS, 0..) |divisor, d| {
                if (divisor > 0 and input_hz * multiplier / divisor == target_hz) {
                    pll_mul = m;
                    pll_div = d;
                    break :pll_selection;
                }
            }
        } else {
            @compileError("PLL solution could not be found.");
        }
    }

    RCC.CFGR.modify(.{
        .PLLSRC = pll_src,
        .PLLMUL = pll_mul,
        .PLLDIV = pll_div,
    });

    pll_enable(1);
}

/// Selects the clock source for the system clock (SYSCLK).
/// This directly sets the CPU frequency.
fn sysclk_set_src(comptime src: ClockSource) void {
    RCC.CFGR.modify(.{ .SW = @intFromEnum(src) });
    while (RCC.CFGR.read().SWS != @intFromEnum(src)) {
        cmsis.nop();
    }
}

// Configure the HCLk and peripheral bus dividers.
// These are for nerds anyway.
fn configure_bus_clocks() void {
    RCC.CFGR.modify(.{
        .HPRE = 0, // HCLK divider (to the CPU)
        .PPRE1 = 0, // APB1 divider (Peripheral bus 1)
        .PPRE2 = 0, // APB1 divider (Peripheral bus 2)
    });
}
