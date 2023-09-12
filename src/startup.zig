const main = @import("main.zig");

// These symbols come from the linker script
extern const _data_loadaddr: u32;
extern const _data: u32;
extern const _edata: u32;
extern const _bss: u32;
extern const _ebss: u32;
// Stack pointer is also a u32, but we lie to get it into the vector.
extern fn _estack() void;

export fn resetHandler() void {
    // Copy data from flash to RAM
    const data_loadaddr: [*]const u8 = @ptrCast(&_data_loadaddr);
    const data: [*]u8 = @ptrCast(&_data);
    const data_size: u32 = @intFromPtr(&_edata) - @intFromPtr(&_data);
    for (data_loadaddr[0..data_size], 0..) |d, i| {
        data[i] = d;
    }

    // Clear the bss
    const bss = @as([*]u8, @ptrCast(&_bss));
    const bss_size = @intFromPtr(&_ebss) - @intFromPtr(&_bss);
    for (bss[0..bss_size]) |*b| {
        b.* = 0;
    }

    // Call contained in main.zig
    main.main();
}

// The ISR vector table.
export const vector_table linksection(".vector") = [_](*const fn () callconv(.C) void){
    _estack, // Stack pointer
    resetHandler, // Reset handler (entry point)
};
