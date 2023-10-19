const std = @import("std");
const regs = @import("device.zig").regs;
const cmsis = @import("cmsis.zig");

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

pub const PinConfig = struct {
    mode: Mode,
    pull: Pull = .none,
    speed: Speed = .slow,
    output_type: OutputType = .push_pull,
};

pub fn new(comptime pin_name: []const u8) Pin {
    comptime var pins: u16 = 0;
    comptime var port: ?u16 = null;

    comptime {
        var tok = std.mem.tokenize(u8, pin_name, "|");

        while (tok.next()) |word| {
            pins |= cmsis.lshift(u16, 1, parse_pin_number(word));
            const inst_port = parse_pin_port(word);
            if (port == null) {
                port = inst_port;
            } else if (port != inst_port) {
                @compileError("GPIO unions must have the same GPIO port");
            }
        }
    }

    return .{
        .pin = pins,
        .port = port.?,
    };
}

/// Represents a GPIO pin.
/// It packed into a single 32 bit word, and may be passed by value.
/// Create one using GPIO.new('PA13')
pub const Pin = packed struct(u32) {
    pin: u16,
    port: u16,

    /// Inline initializer for other more explicit initialization methods
    inline fn init(gpio: Pin, config: PinConfig) void {
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
    pub fn init_output(gpio: Pin, state: u1) void {
        // The default state should be set before the MODER register is touched
        gpio.write(state);
        gpio.init(.{
            .mode = .output,
        });
    }

    /// Initialises the pin as an input.
    /// The pullup/down should also be specified here.
    pub fn init_input(gpio: Pin, pull: Pull) void {
        gpio.init(.{
            .mode = .input,
            .pull = pull,
        });
    }

    pub fn init_alternate(comptime gpio: Pin, output_type: OutputType, comptime af: regs.GPIO_Function) void {
        const af_n = lookup_af(gpio, af);
        gpio.init_alternate_af(output_type, af_n);
    }

    /// Initialises the pin into an alternate funciton mode.
    /// This is used by peripherals to take control of pins.
    pub fn init_alternate_af(gpio: Pin, output_type: OutputType, af: u4) void {
        gpio.set_alternate_function(af);
        gpio.init(.{
            .mode = .alternate,
            .speed = .fastest,
            .output_type = output_type,
        });
    }

    /// Returns the pin to its high-z analog mode.
    /// This is also the pin mode required for some analog peripherals.
    pub fn deinit(gpio: Pin) void {
        gpio.init(.{
            .mode = .analog,
        });
    }

    /// Reads the state of the GPIO
    pub fn read(gpio: Pin) u1 {
        const port = get_port(gpio.port);
        return if (port.IDR.read_word() & gpio.pin > 0) 1 else 0;
    }

    /// Sets the GPIO output state to low or high.
    /// The pin should already be initialized into output mode.
    pub fn write(gpio: Pin, state: u1) void {
        const port = get_port(gpio.port);
        if (state > 0) {
            port.BSRR.write_word(gpio.pin);
        } else {
            port.BRR.write_word(gpio.pin);
        }
    }

    /// Configures the given pin(s) to the specified alternate function.
    inline fn set_alternate_function(gpio: Pin, af: u4) void {
        const port = get_port(gpio.port);
        var pins: u32 = gpio.pin;
        // Check each pin.
        for (0..16) |i| {
            if (pins & 1 > 0) {

                // The pin modes are split across AFRL and AFRH in 4 bit blocks.
                const alt_offset = (i & 0x7) * 4;
                const alt_mask = cmsis.lshift(u32, 0x0F, alt_offset);
                const alt_af = cmsis.lshift(u32, af, alt_offset);
                if (i <= 0x7) {
                    port.AFRL.modify_word(alt_mask, alt_af);
                } else {
                    port.AFRH.modify_word(alt_mask, alt_af);
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
fn get_port(port: u16) *regs.GPIO_Peripheral {
    const gpio_base = comptime @intFromPtr(regs.GPIOA);
    const gpio_stride = comptime @intFromPtr(regs.GPIOB) - gpio_base;
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

/// Finds the alternate function id for the given pin and function.
/// This works on GPIO Pin groups, and will confirm that they use the same AF value.
pub fn lookup_af(comptime gpio: Pin, comptime func: regs.GPIO_Function) u4 {
    return comptime find_af: {
        var af: ?u4 = null;
        for (0..16) |i| {
            if (gpio.pin & (1 << i) > 0) {
                const pin_af = lookup_af_single(gpio.port, i, func);
                if (af == null) {
                    af = pin_af;
                } else if (af != pin_af) {
                    @compileError("Alternate function lookup must find common offset.");
                }
            }
        }
        break :find_af af.?;
    };
}

/// Finds the alternate function id based on the given pin and function.
/// This works for a single pin
fn lookup_af_single(comptime port: u16, comptime pin: u4, comptime func: regs.GPIO_Function) u4 {
    return comptime find_af: {
        const row = regs.GPIO_FunctionTable[port][pin];
        for (row, 0..) |raf, i| {
            if (raf == func) {
                break :find_af i;
            }
        }
        @compileError("Alternate function lookup failure!");
    };
}

test "pin parsing" {
    try std.testing.expect(parse_pin_number("PB12") == 12);
    try std.testing.expect(parse_pin_port("PB12") == 1);

    const pb12 = Pin.new("PB12");
    try std.testing.expect(pb12.pin == (1 << 12));
    try std.testing.expect(pb12.port == 1);

    const pair = Pin.new("PA9|PA10");
    try std.testing.expect(pair.pin == ((1 << 9) | (1 << 10)));
    try std.testing.expect(pair.port == 0);
}

test "bit doubling" {
    try std.testing.expect(bit_double(0b00000000) == 0b00000000);
    try std.testing.expect(bit_double(0b00000001) == 0b00000001);
    try std.testing.expect(bit_double(0b01001101) == 0b0001000001010001);
    try std.testing.expect(bit_double(1 << 15) == 1 << 30);
}
