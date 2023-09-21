const cmsis = @import("cmsis.zig");
const clock = @import("clock.zig");
const regs = @import("device.zig").regs;

const RCC = regs.RCC;

const systick_hz = 1000;

pub fn init() void {
    clock.init();
    enable_gpio_clocks();
    cmsis.systick_config(clock.get_sysclk_hz() / systick_hz);
}

pub fn reset() void {
    cmsis.reset();
}

pub fn get_tick() u32 {
    // Systick can change under interrupt
    return @volatileCast(&systick_value).*;
}

pub fn delay(time_ms: u32) void {
    // We might be near a tick rollover, so we add a minimum delay.
    const time_ms_min = time_ms + (1000 / systick_hz);
    const start_time = get_tick();
    while (get_tick() - start_time < time_ms_min) {
        cmsis.wfi();
    }
}

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
