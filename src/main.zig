const mcu = @import("STM32Z/mcu.zig").mcu;
const GPIO = @import("STM32Z/GPIO.zig").GPIO;
const CORE = @import("STM32Z/CORE.zig").CORE;

const core = CORE.new();

const led_red = GPIO.new("PB3");
const led_grn = GPIO.new("PB4");
const led_blu = GPIO.new("PB5");

pub fn main() void {
    core.init();

    led_red.init_output(0);

    while (true) {}
}
