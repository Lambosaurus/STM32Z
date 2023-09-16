const device = @import("stm32z/device.zig").device;
const MCU = @import("stm32z/mcu.zig").MCU;
const GPIO = @import("stm32z/gpio.zig").GPIO;
const UART = @import("stm32z/uart.zig").UART;

const mcu = MCU.new(.{
    .sysclk_hz = 32_000_000,
    .clock_source = .hsi,
});

const led_red = GPIO.new("PB3");
const led_grn = GPIO.new("PB4");
const led_blu = GPIO.new("PB5");

const uart = UART{
    .mcu = mcu,
    .baud = 115200,
    .instance = device.USART1,
    .pins = GPIO.new("PA9|PA10"),
};

const tx_pin = GPIO.new("PA9");

pub fn main() void {
    mcu.init();
    uart.init();
    led_red.init_output(1);
    led_blu.init_output(1);
    while (true) {
        led_red.write(0);
        uart.write("Tick\n");
        led_red.write(1);
        mcu.delay(1000);
    }
}
