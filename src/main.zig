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
    led_red.init_output(1);
    led_grn.init_output(1);
    while (true) {
        led_red.write(1);
        led_grn.write(0);
        mcu.delay(1000);
        led_red.write(0);
        led_grn.write(1);
        mcu.delay(1000);
    }
}
