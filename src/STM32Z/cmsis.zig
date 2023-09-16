const device = @import("device.zig").device;

const STK = device.STK;
const SCB = device.SCB;

pub inline fn nop() void {
    asm volatile ("nop;");
}

pub inline fn wfi() void {
    asm volatile ("wfi;");
}

pub fn reset() void {
    asm volatile ("dsb;");
    SCB.AIRCR.modify(.{
        .SYSRESETREQ = 1,
        .VECTKEYSTAT = 0x5FA,
    });
    asm volatile ("dsb;");
    while (true) {
        nop();
    }
}

pub fn systick_config(comptime ticks: comptime_int) void {
    STK.RVR.write(.{ .RELOAD = ticks - 1 });
    STK.CVR.write(.{ .CURRENT = 0 });
    STK.CSR.write(.{
        .ENABLE = 1,
        .TICKINT = 1,
        .CLKSOURCE = 1,
    });
}
