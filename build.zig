const std = @import("std");
const Builder = std.build.Builder;
const LazyPath = std.build.LazyPath;
const Step = std.build.Step;

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

    // Step for printing out file info.
    var my_step = try StatStep.create(b, bin.getOutput());
    my_step.step.dependOn(&bin.step);
    b.default_step.dependOn(&my_step.step);

    // Copy the bin to the output directory.
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

pub const StatStep = struct {
    step: Step,
    b: *Builder,
    path: LazyPath,

    pub fn create(b: *Builder, path: LazyPath) !*StatStep {
        const self = b.allocator.create(StatStep) catch unreachable;
        self.* = .{
            .step = std.build.Step.init(.{
                .id = .custom,
                .name = "name",
                .owner = b,
                .makeFn = &make,
            }),
            .b = b,
            .path = path,
        };
        return self;
    }

    fn make(step: *Step, prog_node: *std.Progress.Node) anyerror!void {
        _ = prog_node;
        const self = @fieldParentPtr(StatStep, "step", step);
        const path = self.path.getPath(self.step.owner);

        var file = try std.fs.openFileAbsolute(path, .{ .mode = .read_only });
        const size = try file.getEndPos();
        file.close();

        std.debug.print("Binary size: {d} bytes\n", .{size});
    }
};
