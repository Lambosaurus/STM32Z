const regs = @import("device.zig").regs;

pub inline fn nop() void {
    asm volatile ("nop;");
}

pub inline fn wfi() void {
    asm volatile ("wfi;");
}

pub fn reset() void {
    asm volatile ("dsb;");
    regs.SCB.AIRCR.modify(.{
        .SYSRESETREQ = 1,
        .VECTKEYSTAT = 0x5FA,
    });
    asm volatile ("dsb;");
    while (true) {
        nop();
    }
}

/// Initialises the Cortex M0's system tick.
/// The period is specified in hclk ticks - and so the output frequency is hclk / ticks.
pub fn systick_config(comptime ticks: comptime_int) void {
    regs.STK.RVR.write(.{ .RELOAD = ticks - 1 });
    regs.STK.CVR.write(.{ .CURRENT = 0 });
    regs.STK.CSR.write(.{
        .ENABLE = 1,
        .TICKINT = 1,
        .CLKSOURCE = 1,
    });
}

/// Enables/disables the system tick interrupt.
pub fn systick_enable(comptime enable: u1) void {
    regs.STK.CSR.write(.{ .ENABLE = enable });
}

/// A replacement for lhs << rhs.
/// This is just to hide a bunch of junk casts.
/// This isnt really a part of cmsis...
pub inline fn lshift(comptime T: type, lhs: T, rhs: T) T {
    return lhs << @truncate(rhs);
}
