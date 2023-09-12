const mcu = @import("STM32Z/MCU/STM32L0x3.zig");

pub fn main() void {
    mcu.RCC.IOPENR.write(.{ .IOPBEN = 1 });
    asm volatile ("nop;");

    var moder = mcu.GPIOB.MODER.read();
    moder.MODE3 = 1;
    mcu.GPIOB.MODER.write(moder);
    mcu.GPIOB.ODR.write(.{});

    while (true) {}
}
