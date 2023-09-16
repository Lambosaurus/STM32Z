const device = @import("device.zig").device;
const cmsis = @import("cmsis.zig");
const Clock = @import("clock.zig").Clock;
const RCC = device.RCC;

pub const MCU = struct {
    clk: Clock,
    systick_hz: comptime_int = 1000,

    pub fn new(comptime clk: Clock) MCU {
        return .{
            .clk = clk,
        };
    }

    pub fn init(comptime mcu: MCU) void {
        mcu.clk.init();
        enable_gpio_clocks();
        cmsis.systick_config(mcu.clk.get_sysclk_hz() / mcu.systick_hz);
    }

    pub fn reset(comptime mcu: MCU) void {
        _ = mcu;
        cmsis.reset();
    }

    pub fn get_tick(comptime mcu: MCU) u32 {
        _ = mcu;
        // Systick can change under interrupt
        return @volatileCast(&systick_value).*;
    }

    pub fn delay(comptime mcu: MCU, time_ms: u32) void {
        // We might be near a tick rollover, so we add a minimum delay.
        const time_ms_min = time_ms + (1000 / mcu.systick_hz);
        const start_time = mcu.get_tick();
        while (mcu.get_tick() - start_time < time_ms_min) {
            cmsis.nop();
        }
    }
};

fn enable_gpio_clocks() void {
    // Enable all the GPIO clocks
    RCC.IOPENR.write(.{
        .IOPBEN = 1,
        .IOPAEN = 1,
        .IOPCEN = 1,
        .IOPDEN = 1,
        .IOPEEN = 1,
        .IOPHEN = 1,
    });
    cmsis.nop();
}

/// Global systick counter
var systick_value: u32 = 0;

/// IRQ handler for the system tick.
pub export fn systemTickHandler() void {
    systick_value += 1;
}
