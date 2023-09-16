const MCU = @import("stm32z/mcu.zig").MCU;
const GPIO = @import("stm32z/gpio.zig").GPIO;

const mcu = MCU.new(.{
    .sysclk_hz = 32_000_000,
    .clock_source = .hsi,
});

const led_red = GPIO.new("PB3");
const led_grn = GPIO.new("PB4");
const led_blu = GPIO.new("PB5");

pub fn main() void {
    mcu.init();
    led_red.init_output(0);
    while (true) {}
}
