const regs = @import("stm32z/device.zig").regs;

const mcu = @import("stm32z/mcu.zig");
const gpio = @import("stm32z/gpio.zig");
const uart = @import("stm32z/uart.zig");

const clock = @import("stm32z/clock.zig");

pub const device_config: struct {
    clock: clock.ClockConfig = .{
        .sysclk_hz = 32_000_000,
        .clock_source = .hsi,
    },
} = .{};

const led_red = gpio.new("PB3");
const led_grn = gpio.new("PB4");
const led_blu = gpio.new("PB5");

//const uart = UART{
//    .mcu = mcu,
//    .baud = 115200,
//    .instance = device.USART1,
//    .pins = gpio.new("PA9|PA10"),
//};

var uart1 = uart.new(regs.USART1);

pub fn main() void {
    mcu.init();
    uart1.init(.{
        .baud = 115200,
        .pins = gpio.new("PA9|PA10"),
    });
    led_red.init_output(1);
    led_blu.init_output(1);

    while (true) {
        led_blu.write(0);
        uart1.write("Tick\n");
        led_blu.write(1);
        mcu.delay(1000);
    }
}
