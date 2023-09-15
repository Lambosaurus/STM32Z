const std = @import("std");
const mcu = @import("mcu.zig").mcu;
const CLK = @import("CLK.zig").CLK;

const RCC = mcu.RCC;

/// A grouping object for common features that need to be shared between many peripherals.
/// This includes the clock configuration.
pub const CORE = struct {
    clk: CLK,

    pub fn new() CORE {
        return .{
            .clk = CLK.new(),
        };
    }

    pub fn init(comptime core: CORE) void {
        core.clk.init();
        core.enable_gpio_clocks();
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
        asm volatile ("nop;");
    }

    //pub fn delay() void {
    //
    //}
};