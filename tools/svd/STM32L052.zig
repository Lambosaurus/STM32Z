pub const AF_TABLE = [_][2][8]AlternateFunction{
    //GPIOA
    .{
        //PA0
        .{ .none, .none, .tim2, .tsc, .usart2, .tim2, .none, .comp1 },
        //PA1
        .{ .eventout, .none, .tim2, .tsc, .usart2, .tim21, .none, .none },
        //PA2
        .{ .tim21, .none, .tim2, .tsc, .usart2, .none, .none, .comp2 },
        //PA3
        .{ .tim21, .none, .tim2, .tsc, .usart2, .none, .none, .none },
        //PA4
        .{ .spi1, .none, .none, .tsc, .usart2, .tim22, .none, .none },
        //PA5
        .{ .spi1, .none, .tim2, .tsc, .tim2, .none, .none, .none },
        //PA6
        .{ .spi1, .none, .none, .tsc, .lpuart1, .tim22, .eventout, .comp1 },
        //PA7
        .{ .spi1, .none, .none, .tsc, .tim22, .eventout, .comp2, .none },
        //PA8
        .{ .mco, .none, .usb, .eventout, .usart1, .none, .none, .none },
        //PA9
        .{ .mco, .none, .none, .tsc, .usart1, .none, .none, .none },
        //PA10
        .{ .none, .none, .none, .tsc, .usart1, .none, .none, .none },
        //PA11
        .{ .spi1, .none, .eventout, .tsc, .usart1, .none, .none, .comp1 },
        //PA12
        .{ .spi1, .none, .eventout, .tsc, .usart1, .none, .none, .comp2 },
        //PA13
        .{ .swd, .none, .usb, .none, .none, .none, .none, .none },
        //PA14
        .{ .swd, .none, .none, .none, .usart2, .none, .none, .none },
        //PA15
        .{ .spi1, .none, .tim2, .eventout, .usart2, .tim2, .none, .none },
    },
    //GPIOA
    .{
        //PB0
        .{ .eventout, .none, .none, .tsc, .none, .none, .none, .none },
        //PB1
        .{ .none, .none, .none, .tsc, .lpuart1, .none, .none, .none },
        //PB2
        .{ .none, .none, .lptim1, .tsc, .none, .none, .none, .none },
        //PB3
        .{ .spi1, .none, .tim2, .tsc, .eventout, .none, .none, .none },
        //PB4
        .{ .spi1, .none, .eventout, .tsc, .tim22, .none, .none, .none },
        //PB5
        .{ .spi1, .none, .lptim1, .i2c1, .tim22, .none, .none, .none },
        //PB6
        .{ .usart1, .i2c1, .lptim1, .tsc, .none, .none, .none, .none },
        //PB7
        .{ .usart1, .i2c1, .lptim1, .tsc, .none, .none, .none, .none },
        //PB8
        .{ .none, .none, .none, .tsc, .i2c1, .none, .none, .none },
        //PB9
        .{ .none, .none, .eventout, .none, .i2c1, .spi2, .none, .none },
        //PB10
        .{ .none, .none, .tim2, .tsc, .lpuart1, .spi2, .i2c2, .none },
        //PB11
        .{ .eventout, .none, .tim2, .tsc, .lpuart1, .none, .i2c2, .none },
        //PB12
        .{ .spi2, .none, .lpuart1, .tsc, .none, .i2c2, .eventout, .none },
        //PB13
        .{ .spi2, .none, .none, .tsc, .lpuart1, .i2c2, .tim21, .none },
        //PB14
        .{ .spi2, .none, .rtc, .tsc, .lpuart1, .i2c2, .tim21, .none },
        //PB15
        .{ .spi2, .none, .rtc, .none, .none, .none, .none, .none },
    },
    //GPIOA
    .{
        //PC0
        .{ .lptim1, .none, .eventout, .tsc, .none, .none, .none, .none },
        //PC1
        .{ .lptim1, .none, .eventout, .tsc, .none, .none, .none, .none },
        //PC2
        .{ .lptim1, .none, .spi2, .tsc, .none, .none, .none, .none },
        //PC3
        .{ .lptim1, .none, .spi2, .tsc, .none, .none, .none, .none },
        //PC4
        .{ .eventout, .none, .lpuart1, .none, .none, .none, .none, .none },
        //PC5
        .{ .none, .none, .lpuart1, .tsc, .none, .none, .none, .none },
        //PC6
        .{ .tim22, .none, .none, .tsc, .none, .none, .none, .none },
        //PC7
        .{ .tim22, .none, .none, .tsc, .none, .none, .none, .none },
        //PC8
        .{ .tim22, .none, .none, .tsc, .none, .none, .none, .none },
        //PC9
        .{ .tim21, .none, .usb, .tsc, .none, .none, .none, .none },
        //PC10
        .{ .lpuart1, .none, .none, .none, .none, .none, .none, .none },
        //PC11
        .{ .lpuart1, .none, .none, .none, .none, .none, .none, .none },
        //PC12
        .{ .none, .none, .none, .none, .none, .none, .none, .none },
        //PC13
        .{ .none, .none, .none, .none, .none, .none, .none, .none },
        //PC14
        .{ .none, .none, .none, .none, .none, .none, .none, .none },
        //PC15
        .{ .none, .none, .none, .none, .none, .none, .none, .none },
    },
};
