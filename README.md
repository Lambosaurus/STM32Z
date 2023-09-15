# STM32Z

This is a HAL for STM32's written in Zig.

It will have a similar scope as [STM32X](https://github.com/Lambosaurus/STM32X), but I aim to make as much of the device configuration happen at comptime.

The (eventual) scope of this project is:
 * Provide build scripts that work out of the box with plain zig.
 * Provide linker files, startup shims, and vector table generations.
 * Providing register defintions files.
 * Providing a HAL for easy peripheral configuration.
 * Provide debugging and flashing commands.

I will start with targeting `STM32L0`'s, and then gradually extend support for the `STM32F0`, `STM32G0` and `STM32C0` series.

