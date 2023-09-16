const std = @import("std");
const Builder = std.build.Builder;

pub fn build(b: *Builder) void {
    const optimization = std.builtin.OptimizeMode.ReleaseSmall;
    const cpu_model = &std.Target.arm.cpu.cortex_m0;

    // Build the elf
    const elf = b.addExecutable(.{
        .name = "output.elf",
        .root_source_file = .{ .path = "src/startup.zig" },
        .target = .{
            .cpu_arch = .thumb,
            .os_tag = .freestanding,
            .abi = .none,
            .cpu_model = .{ .explicit = cpu_model },
        },
        .optimize = optimization,
        .single_threaded = true,
    });
    elf.setLinkerScript(.{ .path = "src/stm32z/devices/STM32L052.ld" });

    // Copy the elf to the output directory.
    const copy_elf = b.addInstallArtifact(elf, .{});
    b.default_step.dependOn(&copy_elf.step);

    // Copy the bin out of the elf
    const bin = b.addObjCopy(elf.getEmittedBin(), .{
        .format = .bin,
    });
    bin.step.dependOn(&elf.step);

    // Copy the bin to the output directory
    const copy_bin = b.addInstallBinFile(bin.getOutput(), "output.bin");
    b.default_step.dependOn(&copy_bin.step);

    const flash_bin = b.addSystemCommand(get_flash_command());
    flash_bin.step.dependOn(&copy_bin.step);
    const flash_step = b.step("flash", "flash the target");
    flash_step.dependOn(&flash_bin.step);
}

pub fn get_flash_command() []const []const u8 {
    return &.{
        "./tools/openocd/bin/openocd.exe",
        "-s",
        "./tools/openocd/scripts/",
        "-f",
        "default.cfg",
        "-c",
        "source [find target/stm32l0.cfg]",
        "-c",
        "program \"./zig-out/bin/output.bin\" 0x08000000 reset",
        "-c",
        "shutdown",
    };
}
