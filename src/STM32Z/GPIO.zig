const std = @import("std");
const mcu = @import("mcu.zig").mcu;

const Mode = enum(u2) {
    input = 0,
    output = 1,
    alternate = 2,
    analog = 3,
};

const Pull = enum(u2) {
    none = 0,
    up = 1,
    down = 2,
};

const Speed = enum(u2) {
    slow = 0,
    medium = 1,
    fast = 2,
    fastest = 3,
};

const OutputType = enum(u1) {
    push_pull = 0,
    open_drain = 1,
};

pub const GPIOConfig = struct {
    mode: Mode,
    pull: Pull = .none,
    speed: Speed = .slow,
    output_type: OutputType = .push_pull,
};

/// Represents a GPIO pin.
/// It packed into a single 32 bit word, and may be passed by value.
/// Create one using GPIO.new('PA13')
pub const GPIO = packed struct(u32) {
    pin: u16,
    port: u16,

    pub fn new(comptime pin_name: []const u8) GPIO {
        return .{
            .pin = 1 << parse_pin_number(pin_name),
            .port = parse_pin_port(pin_name),
        };
    }

    /// Allows the joining of multiple GPIO for batching GPIO operations.
    /// This is useful for GPIO, where multiple IO need to be set at once.
    /// PA0, PA1 may be merged into a single IO for the purposes of UART initialisation, ect.
    pub fn join(comptime gpio_list: []GPIO) GPIO {
        const port = gpio_list[0].port;
        var pins: u16 = 0;

        for (gpio_list) |gpio| {
            comptime {
                if (gpio.port != port) {
                    @compileError("Joined GPIO must be on the same port.");
                }
            }
            pins |= gpio.pin;
        }

        return .{
            .pin = pins,
            .port = port,
        };
    }

    /// Inline initializer for other more explicit initialization methods
    inline fn init(gpio: GPIO, config: GPIOConfig) void {
        const port = get_port(gpio.port);

        // Most of the registers are 2 bit fields, using the same layout.
        const dpin = bit_double(gpio.pin);
        const dmask = dpin * 0x3;

        if (config.mode == .output or config.mode == .alternate) {
            // These registers only matter for output modes.
            port.OSPEEDR.modify_word(dmask, @intFromEnum(config.speed) * dpin);
            port.OTYPER.modify_word(gpio.pin, @intFromEnum(config.output_type) * gpio.pin);
        }
        port.PUPDR.modify_word(dmask, @intFromEnum(config.pull) * dpin);
        port.MODER.modify_word(dmask, @intFromEnum(config.mode) * dpin);
    }

    /// Initialises this pin as a general output.
    /// The initial state is also set to prevent glitches.
    pub fn init_output(gpio: GPIO, state: u1) void {
        // The default state should be set before the MODER register is touched
        gpio.write(state);
        gpio.init(.{
            .mode = .output,
        });
    }

    /// Initialises the pin as an input.
    /// The pullup/down should also be specified here.
    pub fn init_input(gpio: GPIO, pull: Pull) void {
        gpio.init(.{
            .mode = .input,
            .pull = pull,
        });
    }

    /// Initialises the pin into an alternate funciton mode.
    /// This is used by peripherals to take control of pins.
    pub fn init_alternate(gpio: GPIO, output_type: OutputType, af: u4) void {
        gpio.init(.{
            .mode = .alternate,
            .speed = .fastest,
            .output_type = output_type,
        });
        gpio.set_alternate_function(af);
    }

    /// Returns the pin to its high-z analog mode.
    /// This is also the pin mode required for some analog peripherals.
    pub fn deinit(gpio: GPIO) void {
        gpio.init(.{
            .mode = .analog,
        });
    }

    /// Reads the state of the GPIO
    pub fn read(gpio: GPIO) u1 {
        const port = get_port(gpio.port);
        return if (port.IDR.read_word() & gpio.pin > 0) 1 else 0;
    }

    /// Sets the GPIO output state to low or high.
    /// The pin should already be initialized into output mode.
    pub fn write(gpio: GPIO, state: u1) void {
        const port = get_port(gpio.port);
        if (state > 0) {
            port.BSRR.write_word(gpio.pin);
        } else {
            port.BRR.write_word(gpio.pin);
        }
    }

    /// Configures the given pin(s) to the specified alternate function.
    inline fn set_alternate_function(gpio: GPIO, af: u4) void {
        const port = get_port(gpio.port);
        var pins = gpio.pin;
        // Check each pin.
        for (0..16) |i| {
            if (pins & 1) {

                // The pin modes are split across AFRL and AFRH in 4 bit blocks.
                const alt_offset = (i & 0x7) * 4;
                if (i > 0x7) {
                    port.AFRL.modify_word(0xF << alt_offset, af << alt_offset);
                } else {
                    port.AFRH.modify_word(0xF << alt_offset, af << alt_offset);
                }
            }
            pins >>= 1;
            // Stop checking if the mask is empty
            if (pins == 0) {
                break;
            }
        }
    }
};

/// Returns a SWAR bit doubling based on the provided pin mask.
/// This pads out a bit pattern: 00001011 -> 01000101
fn bit_double(pins: u16) u32 {
    var s: u32 = pins;
    s = (s & 0x00FF00FF) | ((s & 0xFF00FF00) << 8);
    s = (s & 0x0F0F0F0F) | ((s & 0xF0F0F0F0) << 4);
    s = (s & 0x33333333) | ((s & 0xCCCCCCCC) << 2);
    s = (s & 0x55555555) | ((s & 0xAAAAAAAA) << 1);
    return s;
}

/// Returns the GPIO port based on the given port number.
/// This works because GPIO ports have a spacing of 0x400.
fn get_port(port: u16) *mcu.GPIO_Peripheral {
    const gpio_base = comptime @intFromPtr(mcu.GPIOA);
    const gpio_stride = comptime @intFromPtr(mcu.GPIOB) - gpio_base;
    return @ptrFromInt(gpio_base + (gpio_stride * port));
}

/// Helpers for extracting the pin number from a pin string: 'PB12' -> 12
fn parse_pin_number(comptime pin_name: []const u8) u16 {
    return comptime get_pin: {
        if (pin_name.len < 3 or pin_name[0] != 'P') {
            @compileError("Example pin formatting: 'PA0'");
        }

        const pin = std.fmt.parseInt(u32, pin_name[2..], 10) catch unreachable;
        if (pin > 15) {
            @compileError("Pin should be <= 15");
        }
        break :get_pin pin;
    };
}

/// Helpers for extracting the pin number from a pin string: 'PB12' -> 1
fn parse_pin_port(comptime pin_name: []const u8) u16 {
    return comptime get_port: {
        if (pin_name.len < 3 or pin_name[0] != 'P') {
            @compileError("Example pin formatting: 'PA0'");
        }
        const port_letter = pin_name[1];
        if (port_letter < 'A' or port_letter > 'F') {
            @compileError("GPIO Port expected to be in the range A to F.");
        }
        break :get_port (port_letter - 'A');
    };
}

test "pin parsing" {
    try std.testing.expect(parse_pin_number("PB12") == 12);
    try std.testing.expect(parse_pin_port("PB12") == 1);
}

test "bit doubling" {
    try std.testing.expect(bit_double(0b00000000) == 0b00000000);
    try std.testing.expect(bit_double(0b00000001) == 0b00000001);
    try std.testing.expect(bit_double(0b01001101) == 0b0001000001010001);
    try std.testing.expect(bit_double(1 << 15) == 1 << 30);
}
