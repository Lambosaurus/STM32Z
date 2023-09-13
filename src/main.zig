const mcu = @import("STM32Z/mcu.zig").mcu;
const GPIO = @import("STM32Z/GPIO.zig").GPIO;

const led_red = GPIO.new("PB3");
const led_grn = GPIO.new("PB4");
const led_blu = GPIO.new("PB5");

pub fn main() void {
    // Enable the GPIOB bank (Well work on that.)
    mcu.RCC.IOPENR.write(.{ .IOPBEN = 1 });
    asm volatile ("nop;");

    led_grn.init_output(0);

    while (true) {}
}
