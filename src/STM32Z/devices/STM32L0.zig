//! Register and peripheral definitions for the STM32L0x3
//! This file has been generated from the supplied svd file
//! If there are any corrections needed, please edit the svd3zig generator tools

fn r32(comptime T: type) type {
    return packed struct {
        const Self = @This();

        memory: u32,

        pub inline fn read(self: *volatile Self) T {
            return @bitCast(self.memory);
        }

        pub inline fn write(self: *volatile Self, value: T) void {
            self.memory = @bitCast(value);
        }

        pub inline fn read_word(self: *volatile Self) u32 {
            return self.memory;
        }

        pub inline fn write_word(self: *volatile Self, value: u32) void {
            self.memory = value;
        }

        pub inline fn modify(self: *volatile Self, new_value: anytype) void {
            var old_value = self.read();
            const info = @typeInfo(@TypeOf(new_value));
            inline for (info.Struct.fields) |field| {
                @field(old_value, field.name) = @field(new_value, field.name);
            }
            self.write(old_value);
        }

        pub inline fn modify_word(self: *volatile Self, clear: u32, set: u32) void {
            var word = self.memory;
            word &= ~clear;
            word |= set;
            self.memory = word;
        }
    };
}

pub const part_name = "STM32L0x3";

/// CPU Information
pub const CPU = struct {
    pub const core = "CM0+";
    pub const endian = "little;";
    pub const mpu_present = false;
    pub const fpu_present = false;
    pub const nvic_prio_bits = 3;
};

/// Analog-to-digital converter
pub const ADC_Peripheral = packed struct {
    /// [+0x00] interrupt and status register
    ISR: r32(packed struct {
        /// [0:1] ADC ready
        ADRDY: u1 = 0,
        /// [1:2] End of sampling flag
        EOSMP: u1 = 0,
        /// [2:3] End of conversion flag
        EOC: u1 = 0,
        /// [3:4] End of sequence flag
        EOS: u1 = 0,
        /// [4:5] ADC overrun
        OVR: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] Analog watchdog flag
        AWD: u1 = 0,
        _unused8: u3 = 0,
        /// [11:12] End Of Calibration flag
        EOCAL: u1 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x04] interrupt enable register
    IER: r32(packed struct {
        /// [0:1] ADC ready interrupt enable
        ADRDYIE: u1 = 0,
        /// [1:2] End of sampling flag interrupt enable
        EOSMPIE: u1 = 0,
        /// [2:3] End of conversion interrupt enable
        EOCIE: u1 = 0,
        /// [3:4] End of conversion sequence interrupt enable
        EOSIE: u1 = 0,
        /// [4:5] Overrun interrupt enable
        OVRIE: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] Analog watchdog interrupt enable
        AWDIE: u1 = 0,
        _unused8: u3 = 0,
        /// [11:12] End of calibration interrupt enable
        EOCALIE: u1 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x08] control register
    CR: r32(packed struct {
        /// [0:1] ADC enable command
        ADEN: u1 = 0,
        /// [1:2] ADC disable command
        ADDIS: u1 = 0,
        /// [2:3] ADC start conversion command
        ADSTART: u1 = 0,
        _unused3: u1 = 0,
        /// [4:5] ADC stop conversion command
        ADSTP: u1 = 0,
        _unused5: u23 = 0,
        /// [28:29] ADC Voltage Regulator Enable
        ADVREGEN: u1 = 0,
        _unused29: u2 = 0,
        /// [31:32] ADC calibration
        ADCAL: u1 = 0,
    }),
    /// [+0x0C] configuration register 1
    CFGR1: r32(packed struct {
        /// [0:1] Direct memory access enable
        DMAEN: u1 = 0,
        /// [1:2] Direct memery access configuration
        DMACFG: u1 = 0,
        /// [2:3] Scan sequence direction
        SCANDIR: u1 = 0,
        /// [3:5] Data resolution
        RES: u2 = 0,
        /// [5:6] Data alignment
        ALIGN: u1 = 0,
        /// [6:9] External trigger selection
        EXTSEL: u3 = 0,
        _unused9: u1 = 0,
        /// [10:12] External trigger enable and polarity selection
        EXTEN: u2 = 0,
        /// [12:13] Overrun management mode
        OVRMOD: u1 = 0,
        /// [13:14] Single / continuous conversion mode
        CONT: u1 = 0,
        /// [14:15] Auto-delayed conversion mode
        AUTDLY: u1 = 0,
        /// [15:16] Auto-off mode
        AUTOFF: u1 = 0,
        /// [16:17] Discontinuous mode
        DISCEN: u1 = 0,
        _unused17: u5 = 0,
        /// [22:23] Enable the watchdog on a single channel or on all channels
        AWDSGL: u1 = 0,
        /// [23:24] Analog watchdog enable
        AWDEN: u1 = 0,
        _unused24: u2 = 0,
        /// [26:31] Analog watchdog channel selection
        AWDCH: u5 = 0,
        _unused31: u1 = 0,
    }),
    /// [+0x10] configuration register 2
    CFGR2: r32(packed struct {
        /// [0:1] Oversampler Enable
        OVSE: u1 = 0,
        _unused1: u1 = 0,
        /// [2:5] Oversampling ratio
        OVSR: u3 = 0,
        /// [5:9] Oversampling shift
        OVSS: u4 = 0,
        /// [9:10] Triggered Oversampling
        TOVS: u1 = 0,
        _unused10: u20 = 0,
        /// [30:32] ADC clock mode
        CKMODE: u2 = 0,
    }),
    /// [+0x14] sampling time register
    SMPR: r32(packed struct {
        /// [0:3] Sampling time selection
        SMPR: u3 = 0,
        _unused3: u29 = 0,
    }),
    _unused24: [8]u8,
    /// [+0x20] watchdog threshold register
    TR: r32(packed struct {
        /// [0:12] Analog watchdog lower threshold
        LT: u12 = 0,
        _unused12: u4 = 0,
        /// [16:28] Analog watchdog higher threshold
        HT: u12 = 0,
        _unused28: u4 = 0,
    }),
    _unused36: u32,
    /// [+0x28] channel selection register
    CHSELR: r32(packed struct {
        /// [0:1] Channel-x selection
        CHSEL0: u1 = 0,
        /// [1:2] Channel-x selection
        CHSEL1: u1 = 0,
        /// [2:3] Channel-x selection
        CHSEL2: u1 = 0,
        /// [3:4] Channel-x selection
        CHSEL3: u1 = 0,
        /// [4:5] Channel-x selection
        CHSEL4: u1 = 0,
        /// [5:6] Channel-x selection
        CHSEL5: u1 = 0,
        /// [6:7] Channel-x selection
        CHSEL6: u1 = 0,
        /// [7:8] Channel-x selection
        CHSEL7: u1 = 0,
        /// [8:9] Channel-x selection
        CHSEL8: u1 = 0,
        /// [9:10] Channel-x selection
        CHSEL9: u1 = 0,
        /// [10:11] Channel-x selection
        CHSEL10: u1 = 0,
        /// [11:12] Channel-x selection
        CHSEL11: u1 = 0,
        /// [12:13] Channel-x selection
        CHSEL12: u1 = 0,
        /// [13:14] Channel-x selection
        CHSEL13: u1 = 0,
        /// [14:15] Channel-x selection
        CHSEL14: u1 = 0,
        /// [15:16] Channel-x selection
        CHSEL15: u1 = 0,
        /// [16:17] Channel-x selection
        CHSEL16: u1 = 0,
        /// [17:18] Channel-x selection
        CHSEL17: u1 = 0,
        /// [18:19] Channel-x selection
        CHSEL18: u1 = 0,
        _unused19: u13 = 0,
    }),
    _unused44: [20]u8,
    /// [+0x40] data register
    DR: r32(packed struct {
        /// [0:16] Converted data
        DATA: u16 = 0,
        _unused16: u16 = 0,
    }),
    _unused68: [112]u8,
    /// [+0xB4] ADC Calibration factor
    CALFACT: r32(packed struct {
        /// [0:7] Calibration factor
        CALFACT: u7 = 0,
        _unused7: u25 = 0,
    }),
    _unused184: [592]u8,
    /// [+0x308] ADC common configuration register
    CCR: r32(packed struct {
        _unused0: u18 = 0,
        /// [18:22] ADC prescaler
        PRESC: u4 = 0,
        /// [22:23] VREFINT enable
        VREFEN: u1 = 0,
        /// [23:24] Temperature sensor enable
        TSEN: u1 = 0,
        _unused24: u1 = 0,
        /// [25:26] Low Frequency Mode enable
        LFMEN: u1 = 0,
        _unused26: u6 = 0,
    }),
};

/// Advanced encryption standard hardware accelerator
pub const AES_Peripheral = packed struct {
    /// [+0x00] control register
    CR: r32(packed struct {
        /// [0:1] AES enable
        EN: u1 = 0,
        /// [1:3] Data type selection (for data in and data out to/from the cryptographic block)
        DATATYPE: u2 = 0,
        /// [3:5] AES operating mode
        MODE: u2 = 0,
        /// [5:7] AES chaining mode
        CHMOD: u2 = 0,
        /// [7:8] Computation Complete Flag Clear
        CCFC: u1 = 0,
        /// [8:9] Error clear
        ERRC: u1 = 0,
        /// [9:10] CCF flag interrupt enable
        CCFIE: u1 = 0,
        /// [10:11] Error interrupt enable
        ERRIE: u1 = 0,
        /// [11:12] Enable DMA management of data input phase
        DMAINEN: u1 = 0,
        /// [12:13] Enable DMA management of data output phase
        DMAOUTEN: u1 = 0,
        _unused13: u19 = 0,
    }),
    /// [+0x04] status register
    SR: r32(packed struct {
        /// [0:1] Computation complete flag
        CCF: u1 = 0,
        /// [1:2] Read error flag
        RDERR: u1 = 0,
        /// [2:3] Write error flag
        WRERR: u1 = 0,
        _unused3: u29 = 0,
    }),
    /// [+0x08] data input register
    DINR: u32,
    /// [+0x0C] data output register
    DOUTR: u32,
    /// [+0x10] key register 0
    KEYR0: u32,
    /// [+0x14] key register 1
    KEYR1: u32,
    /// [+0x18] key register 2
    KEYR2: u32,
    /// [+0x1C] key register 3
    KEYR3: u32,
    /// [+0x20] initialization vector register 0
    IVR0: u32,
    /// [+0x24] initialization vector register 1
    IVR1: u32,
    /// [+0x28] initialization vector register 2
    IVR2: u32,
    /// [+0x2C] initialization vector register 3
    IVR3: u32,
};

/// Cyclic redundancy check calculation unit
pub const CRC_Peripheral = packed struct {
    /// [+0x00] Data register
    DR: u32,
    /// [+0x04] Independent data register
    IDR: r32(packed struct {
        /// [0:8] General-purpose 8-bit data register bits
        IDR: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x08] Control register
    CR: r32(packed struct {
        /// [0:1] RESET bit
        RESET: u1 = 0,
        _unused1: u2 = 0,
        /// [3:5] Polynomial size
        POLYSIZE: u2 = 0,
        /// [5:7] Reverse input data
        REV_IN: u2 = 0,
        /// [7:8] Reverse output data
        REV_OUT: u1 = 0,
        _unused8: u24 = 0,
    }),
    _unused12: u32,
    /// [+0x10] Initial CRC value
    INIT: u32,
    /// [+0x14] polynomial
    POL: u32,
};

/// Clock recovery system
pub const CRS_Peripheral = packed struct {
    /// [+0x00] control register
    CR: r32(packed struct {
        /// [0:1] SYNC event OK interrupt enable
        SYNCOKIE: u1 = 0,
        /// [1:2] SYNC warning interrupt enable
        SYNCWARNIE: u1 = 0,
        /// [2:3] Synchronization or trimming error interrupt enable
        ERRIE: u1 = 0,
        /// [3:4] Expected SYNC interrupt enable
        ESYNCIE: u1 = 0,
        _unused4: u1 = 0,
        /// [5:6] Frequency error counter enable
        CEN: u1 = 0,
        /// [6:7] Automatic trimming enable
        AUTOTRIMEN: u1 = 0,
        /// [7:8] Generate software SYNC event
        SWSYNC: u1 = 0,
        /// [8:14] HSI48 oscillator smooth trimming
        TRIM: u6 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x04] configuration register
    CFGR: r32(packed struct {
        /// [0:16] Counter reload value
        RELOAD: u16 = 0,
        /// [16:24] Frequency error limit
        FELIM: u8 = 0,
        /// [24:27] SYNC divider
        SYNCDIV: u3 = 0,
        _unused27: u1 = 0,
        /// [28:30] SYNC signal source selection
        SYNCSRC: u2 = 0,
        _unused30: u1 = 0,
        /// [31:32] SYNC polarity selection
        SYNCPOL: u1 = 0,
    }),
    /// [+0x08] interrupt and status register
    ISR: r32(packed struct {
        /// [0:1] SYNC event OK flag
        SYNCOKF: u1 = 0,
        /// [1:2] SYNC warning flag
        SYNCWARNF: u1 = 0,
        /// [2:3] Error flag
        ERRF: u1 = 0,
        /// [3:4] Expected SYNC flag
        ESYNCF: u1 = 0,
        _unused4: u4 = 0,
        /// [8:9] SYNC error
        SYNCERR: u1 = 0,
        /// [9:10] SYNC missed
        SYNCMISS: u1 = 0,
        /// [10:11] Trimming overflow or underflow
        TRIMOVF: u1 = 0,
        _unused11: u4 = 0,
        /// [15:16] Frequency error direction
        FEDIR: u1 = 0,
        /// [16:32] Frequency error capture
        FECAP: u16 = 0,
    }),
    /// [+0x0C] interrupt flag clear register
    ICR: r32(packed struct {
        /// [0:1] SYNC event OK clear flag
        SYNCOKC: u1 = 0,
        /// [1:2] SYNC warning clear flag
        SYNCWARNC: u1 = 0,
        /// [2:3] Error clear flag
        ERRC: u1 = 0,
        /// [3:4] Expected SYNC clear flag
        ESYNCC: u1 = 0,
        _unused4: u28 = 0,
    }),
};

/// Digital-to-analog converter
pub const DAC_Peripheral = packed struct {
    /// [+0x00] control register
    CR: r32(packed struct {
        /// [0:1] DAC channel1 enable
        EN1: u1 = 0,
        /// [1:2] DAC channel1 output buffer disable
        BOFF1: u1 = 0,
        /// [2:3] DAC channel1 trigger enable
        TEN1: u1 = 0,
        /// [3:6] DAC channel1 trigger selection
        TSEL1: u3 = 0,
        /// [6:8] DAC channel1 noise/triangle wave generation enable
        WAVE1: u2 = 0,
        /// [8:12] DAC channel1 mask/amplitude selector
        MAMP1: u4 = 0,
        /// [12:13] DAC channel1 DMA enable
        DMAEN1: u1 = 0,
        /// [13:14] DAC channel1 DMA Underrun Interrupt enable
        DMAUDRIE1: u1 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x04] software trigger register
    SWTRIGR: r32(packed struct {
        /// [0:1] DAC channel1 software trigger
        SWTRIG1: u1 = 0,
        _unused1: u31 = 0,
    }),
    /// [+0x08] channel1 12-bit right-aligned data holding register
    DHR12R1: r32(packed struct {
        /// [0:12] DAC channel1 12-bit right-aligned data
        DACC1DHR: u12 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x0C] channel1 12-bit left-aligned data holding register
    DHR12L1: r32(packed struct {
        _unused0: u4 = 0,
        /// [4:16] DAC channel1 12-bit left-aligned data
        DACC1DHR: u12 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] channel1 8-bit right-aligned data holding register
    DHR8R1: r32(packed struct {
        /// [0:8] DAC channel1 8-bit right-aligned data
        DACC1DHR: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x14] channel2 12-bit right-aligned data holding register
    DHR12R2: r32(packed struct {
        /// [0:12] DAC channel2 12-bit right-aligned data
        DACC2DHR: u12 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x18] channel2 12-bit left-aligned data holding register
    DHR12L2: r32(packed struct {
        _unused0: u4 = 0,
        /// [4:16] DAC channel2 12-bit left-aligned data
        DACC2DHR: u12 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x1C] channel2 8-bit right-aligned data holding register
    DHR8R2: r32(packed struct {
        /// [0:8] DAC channel2 8-bit right-aligned data
        DACC2DHR: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x20] Dual DAC 12-bit right-aligned data holding register
    DHR12RD: r32(packed struct {
        /// [0:12] DAC channel1 12-bit right-aligned data
        DACC1DHR: u12 = 0,
        _unused12: u4 = 0,
        /// [16:28] DAC channel2 12-bit right-aligned data
        DACC2DHR: u12 = 0,
        _unused28: u4 = 0,
    }),
    /// [+0x24] Dual DAC 12-bit left-aligned data holding register
    DHR12LD: r32(packed struct {
        _unused0: u4 = 0,
        /// [4:16] DAC channel1 12-bit left-aligned data
        DACC1DHR: u12 = 0,
        _unused16: u4 = 0,
        /// [20:32] DAC channel2 12-bit left-aligned data
        DACC2DHR: u12 = 0,
    }),
    /// [+0x28] Dual DAC 8-bit right-aligned data holding register
    DHR8RD: r32(packed struct {
        /// [0:8] DAC channel1 8-bit right-aligned data
        DACC1DHR: u8 = 0,
        /// [8:16] DAC channel2 8-bit right-aligned data
        DACC2DHR: u8 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x2C] channel1 data output register
    DOR1: r32(packed struct {
        /// [0:12] DAC channel1 data output
        DACC1DOR: u12 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x30] channel2 data output register
    DOR2: r32(packed struct {
        /// [0:12] DAC channel2 data output
        DACC2DOR: u12 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x34] status register
    SR: r32(packed struct {
        _unused0: u13 = 0,
        /// [13:14] DAC channel1 DMA underrun flag
        DMAUDR1: u1 = 0,
        _unused14: u18 = 0,
    }),
};

/// Debug support
pub const DBGMCU_Peripheral = packed struct {
    /// [+0x00] MCU Device ID Code Register
    IDCODE: r32(packed struct {
        /// [0:12] Device Identifier
        DEV_ID: u12 = 0,
        _unused12: u4 = 0,
        /// [16:32] Revision Identifier
        REV_ID: u16 = 0,
    }),
    /// [+0x04] Debug MCU Configuration Register
    CR: r32(packed struct {
        /// [0:1] Debug Sleep Mode
        DBG_SLEEP: u1 = 0,
        /// [1:2] Debug Stop Mode
        DBG_STOP: u1 = 0,
        /// [2:3] Debug Standby Mode
        DBG_STANDBY: u1 = 0,
        _unused3: u29 = 0,
    }),
    /// [+0x08] APB Low Freeze Register
    APB1_FZ: r32(packed struct {
        /// [0:1] Debug Timer 2 stopped when Core is halted
        DBG_TIMER2_STOP: u1 = 0,
        _unused1: u3 = 0,
        /// [4:5] Debug Timer 6 stopped when Core is halted
        DBG_TIMER6_STOP: u1 = 0,
        _unused5: u5 = 0,
        /// [10:11] Debug RTC stopped when Core is halted
        DBG_RTC_STOP: u1 = 0,
        /// [11:12] Debug Window Wachdog stopped when Core is halted
        DBG_WWDG_STOP: u1 = 0,
        /// [12:13] Debug Independent Wachdog stopped when Core is halted
        DBG_IWDG_STOP: u1 = 0,
        _unused13: u8 = 0,
        /// [21:22] I2C1 SMBUS timeout mode stopped when core is halted
        DBG_I2C1_STOP: u1 = 0,
        /// [22:23] I2C2 SMBUS timeout mode stopped when core is halted
        DBG_I2C2_STOP: u1 = 0,
        _unused23: u8 = 0,
        /// [31:32] LPTIM1 counter stopped when core is halted
        DBG_LPTIMER_STOP: u1 = 0,
    }),
    /// [+0x0C] APB High Freeze Register
    APB2_FZ: r32(packed struct {
        _unused0: u2 = 0,
        /// [2:3] Debug Timer 21 stopped when Core is halted
        DBG_TIMER21_STOP: u1 = 0,
        _unused3: u3 = 0,
        /// [6:7] Debug Timer 22 stopped when Core is halted
        DBG_TIMER22_STO: u1 = 0,
        _unused7: u25 = 0,
    }),
};

/// Direct memory access controller
pub const DMA_Peripheral = packed struct {
    /// [+0x00] interrupt status register
    ISR: r32(packed struct {
        /// [0:1] Channel x global interrupt flag (x = 1 ..7)
        GIF1: u1 = 0,
        /// [1:2] Channel x transfer complete flag (x = 1 ..7)
        TCIF1: u1 = 0,
        /// [2:3] Channel x half transfer flag (x = 1 ..7)
        HTIF1: u1 = 0,
        /// [3:4] Channel x transfer error flag (x = 1 ..7)
        TEIF1: u1 = 0,
        /// [4:5] Channel x global interrupt flag (x = 1 ..7)
        GIF2: u1 = 0,
        /// [5:6] Channel x transfer complete flag (x = 1 ..7)
        TCIF2: u1 = 0,
        /// [6:7] Channel x half transfer flag (x = 1 ..7)
        HTIF2: u1 = 0,
        /// [7:8] Channel x transfer error flag (x = 1 ..7)
        TEIF2: u1 = 0,
        /// [8:9] Channel x global interrupt flag (x = 1 ..7)
        GIF3: u1 = 0,
        /// [9:10] Channel x transfer complete flag (x = 1 ..7)
        TCIF3: u1 = 0,
        /// [10:11] Channel x half transfer flag (x = 1 ..7)
        HTIF3: u1 = 0,
        /// [11:12] Channel x transfer error flag (x = 1 ..7)
        TEIF3: u1 = 0,
        /// [12:13] Channel x global interrupt flag (x = 1 ..7)
        GIF4: u1 = 0,
        /// [13:14] Channel x transfer complete flag (x = 1 ..7)
        TCIF4: u1 = 0,
        /// [14:15] Channel x half transfer flag (x = 1 ..7)
        HTIF4: u1 = 0,
        /// [15:16] Channel x transfer error flag (x = 1 ..7)
        TEIF4: u1 = 0,
        /// [16:17] Channel x global interrupt flag (x = 1 ..7)
        GIF5: u1 = 0,
        /// [17:18] Channel x transfer complete flag (x = 1 ..7)
        TCIF5: u1 = 0,
        /// [18:19] Channel x half transfer flag (x = 1 ..7)
        HTIF5: u1 = 0,
        /// [19:20] Channel x transfer error flag (x = 1 ..7)
        TEIF5: u1 = 0,
        /// [20:21] Channel x global interrupt flag (x = 1 ..7)
        GIF6: u1 = 0,
        /// [21:22] Channel x transfer complete flag (x = 1 ..7)
        TCIF6: u1 = 0,
        /// [22:23] Channel x half transfer flag (x = 1 ..7)
        HTIF6: u1 = 0,
        /// [23:24] Channel x transfer error flag (x = 1 ..7)
        TEIF6: u1 = 0,
        /// [24:25] Channel x global interrupt flag (x = 1 ..7)
        GIF7: u1 = 0,
        /// [25:26] Channel x transfer complete flag (x = 1 ..7)
        TCIF7: u1 = 0,
        /// [26:27] Channel x half transfer flag (x = 1 ..7)
        HTIF7: u1 = 0,
        /// [27:28] Channel x transfer error flag (x = 1 ..7)
        TEIF7: u1 = 0,
        _unused28: u4 = 0,
    }),
    /// [+0x04] interrupt flag clear register
    IFCR: r32(packed struct {
        /// [0:1] Channel x global interrupt clear (x = 1 ..7)
        CGIF1: u1 = 0,
        /// [1:2] Channel x transfer complete clear (x = 1 ..7)
        CTCIF1: u1 = 0,
        /// [2:3] Channel x half transfer clear (x = 1 ..7)
        CHTIF1: u1 = 0,
        /// [3:4] Channel x transfer error clear (x = 1 ..7)
        CTEIF1: u1 = 0,
        /// [4:5] Channel x global interrupt clear (x = 1 ..7)
        CGIF2: u1 = 0,
        /// [5:6] Channel x transfer complete clear (x = 1 ..7)
        CTCIF2: u1 = 0,
        /// [6:7] Channel x half transfer clear (x = 1 ..7)
        CHTIF2: u1 = 0,
        /// [7:8] Channel x transfer error clear (x = 1 ..7)
        CTEIF2: u1 = 0,
        /// [8:9] Channel x global interrupt clear (x = 1 ..7)
        CGIF3: u1 = 0,
        /// [9:10] Channel x transfer complete clear (x = 1 ..7)
        CTCIF3: u1 = 0,
        /// [10:11] Channel x half transfer clear (x = 1 ..7)
        CHTIF3: u1 = 0,
        /// [11:12] Channel x transfer error clear (x = 1 ..7)
        CTEIF3: u1 = 0,
        /// [12:13] Channel x global interrupt clear (x = 1 ..7)
        CGIF4: u1 = 0,
        /// [13:14] Channel x transfer complete clear (x = 1 ..7)
        CTCIF4: u1 = 0,
        /// [14:15] Channel x half transfer clear (x = 1 ..7)
        CHTIF4: u1 = 0,
        /// [15:16] Channel x transfer error clear (x = 1 ..7)
        CTEIF4: u1 = 0,
        /// [16:17] Channel x global interrupt clear (x = 1 ..7)
        CGIF5: u1 = 0,
        /// [17:18] Channel x transfer complete clear (x = 1 ..7)
        CTCIF5: u1 = 0,
        /// [18:19] Channel x half transfer clear (x = 1 ..7)
        CHTIF5: u1 = 0,
        /// [19:20] Channel x transfer error clear (x = 1 ..7)
        CTEIF5: u1 = 0,
        /// [20:21] Channel x global interrupt clear (x = 1 ..7)
        CGIF6: u1 = 0,
        /// [21:22] Channel x transfer complete clear (x = 1 ..7)
        CTCIF6: u1 = 0,
        /// [22:23] Channel x half transfer clear (x = 1 ..7)
        CHTIF6: u1 = 0,
        /// [23:24] Channel x transfer error clear (x = 1 ..7)
        CTEIF6: u1 = 0,
        /// [24:25] Channel x global interrupt clear (x = 1 ..7)
        CGIF7: u1 = 0,
        /// [25:26] Channel x transfer complete clear (x = 1 ..7)
        CTCIF7: u1 = 0,
        /// [26:27] Channel x half transfer clear (x = 1 ..7)
        CHTIF7: u1 = 0,
        /// [27:28] Channel x transfer error clear (x = 1 ..7)
        CTEIF7: u1 = 0,
        _unused28: u4 = 0,
    }),
    /// [+0x08] channel x configuration register
    CCR1: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x0C] channel x number of data register
    CNDTR1: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] channel x peripheral address register
    CPAR1: u32,
    /// [+0x14] channel x memory address register
    CMAR1: u32,
    _unused24: u32,
    /// [+0x1C] channel x configuration register
    CCR2: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x20] channel x number of data register
    CNDTR2: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x24] channel x peripheral address register
    CPAR2: u32,
    /// [+0x28] channel x memory address register
    CMAR2: u32,
    _unused44: u32,
    /// [+0x30] channel x configuration register
    CCR3: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x34] channel x number of data register
    CNDTR3: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x38] channel x peripheral address register
    CPAR3: u32,
    /// [+0x3C] channel x memory address register
    CMAR3: u32,
    _unused64: u32,
    /// [+0x44] channel x configuration register
    CCR4: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x48] channel x number of data register
    CNDTR4: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x4C] channel x peripheral address register
    CPAR4: u32,
    /// [+0x50] channel x memory address register
    CMAR4: u32,
    _unused84: u32,
    /// [+0x58] channel x configuration register
    CCR5: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x5C] channel x number of data register
    CNDTR5: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x60] channel x peripheral address register
    CPAR5: u32,
    /// [+0x64] channel x memory address register
    CMAR5: u32,
    _unused104: u32,
    /// [+0x6C] channel x configuration register
    CCR6: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x70] channel x number of data register
    CNDTR6: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x74] channel x peripheral address register
    CPAR6: u32,
    /// [+0x78] channel x memory address register
    CMAR6: u32,
    _unused124: u32,
    /// [+0x80] channel x configuration register
    CCR7: r32(packed struct {
        /// [0:1] Channel enable
        EN: u1 = 0,
        /// [1:2] Transfer complete interrupt enable
        TCIE: u1 = 0,
        /// [2:3] Half transfer interrupt enable
        HTIE: u1 = 0,
        /// [3:4] Transfer error interrupt enable
        TEIE: u1 = 0,
        /// [4:5] Data transfer direction
        DIR: u1 = 0,
        /// [5:6] Circular mode
        CIRC: u1 = 0,
        /// [6:7] Peripheral increment mode
        PINC: u1 = 0,
        /// [7:8] Memory increment mode
        MINC: u1 = 0,
        /// [8:10] Peripheral size
        PSIZE: u2 = 0,
        /// [10:12] Memory size
        MSIZE: u2 = 0,
        /// [12:14] Channel priority level
        PL: u2 = 0,
        /// [14:15] Memory to memory mode
        MEM2MEM: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x84] channel x number of data register
    CNDTR7: r32(packed struct {
        /// [0:16] Number of data to transfer
        NDT: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x88] channel x peripheral address register
    CPAR7: u32,
    /// [+0x8C] channel x memory address register
    CMAR7: u32,
    _unused144: [24]u8,
    /// [+0xA8] channel selection register
    CSELR: r32(packed struct {
        /// [0:4] DMA channel 1 selection
        C1S: u4 = 0,
        /// [4:8] DMA channel 2 selection
        C2S: u4 = 0,
        /// [8:12] DMA channel 3 selection
        C3S: u4 = 0,
        /// [12:16] DMA channel 4 selection
        C4S: u4 = 0,
        /// [16:20] DMA channel 5 selection
        C5S: u4 = 0,
        /// [20:24] DMA channel 6 selection
        C6S: u4 = 0,
        /// [24:28] DMA channel 7 selection
        C7S: u4 = 0,
        _unused28: u4 = 0,
    }),
};

/// External interrupt/event controller
pub const EXTI_Peripheral = packed struct {
    /// [+0x00] Interrupt mask register (EXTI_IMR)
    IMR: r32(packed struct {
        /// [0:1] Interrupt Mask on line 0
        IM0: u1 = 0,
        /// [1:2] Interrupt Mask on line 1
        IM1: u1 = 0,
        /// [2:3] Interrupt Mask on line 2
        IM2: u1 = 0,
        /// [3:4] Interrupt Mask on line 3
        IM3: u1 = 0,
        /// [4:5] Interrupt Mask on line 4
        IM4: u1 = 0,
        /// [5:6] Interrupt Mask on line 5
        IM5: u1 = 0,
        /// [6:7] Interrupt Mask on line 6
        IM6: u1 = 0,
        /// [7:8] Interrupt Mask on line 7
        IM7: u1 = 0,
        /// [8:9] Interrupt Mask on line 8
        IM8: u1 = 0,
        /// [9:10] Interrupt Mask on line 9
        IM9: u1 = 0,
        /// [10:11] Interrupt Mask on line 10
        IM10: u1 = 0,
        /// [11:12] Interrupt Mask on line 11
        IM11: u1 = 0,
        /// [12:13] Interrupt Mask on line 12
        IM12: u1 = 0,
        /// [13:14] Interrupt Mask on line 13
        IM13: u1 = 0,
        /// [14:15] Interrupt Mask on line 14
        IM14: u1 = 0,
        /// [15:16] Interrupt Mask on line 15
        IM15: u1 = 0,
        /// [16:17] Interrupt Mask on line 16
        IM16: u1 = 0,
        /// [17:18] Interrupt Mask on line 17
        IM17: u1 = 0,
        /// [18:19] Interrupt Mask on line 18
        IM18: u1 = 0,
        /// [19:20] Interrupt Mask on line 19
        IM19: u1 = 0,
        /// [20:21] Interrupt Mask on line 20
        IM20: u1 = 0,
        /// [21:22] Interrupt Mask on line 21
        IM21: u1 = 0,
        /// [22:23] Interrupt Mask on line 22
        IM22: u1 = 0,
        /// [23:24] Interrupt Mask on line 23
        IM23: u1 = 0,
        /// [24:25] Interrupt Mask on line 24
        IM24: u1 = 0,
        /// [25:26] Interrupt Mask on line 25
        IM25: u1 = 0,
        /// [26:27] Interrupt Mask on line 27
        IM26: u1 = 0,
        _unused27: u1 = 0,
        /// [28:29] Interrupt Mask on line 27
        IM28: u1 = 0,
        /// [29:30] Interrupt Mask on line 27
        IM29: u1 = 0,
        _unused30: u2 = 0,
    }),
    /// [+0x04] Event mask register (EXTI_EMR)
    EMR: r32(packed struct {
        /// [0:1] Event Mask on line 0
        EM0: u1 = 0,
        /// [1:2] Event Mask on line 1
        EM1: u1 = 0,
        /// [2:3] Event Mask on line 2
        EM2: u1 = 0,
        /// [3:4] Event Mask on line 3
        EM3: u1 = 0,
        /// [4:5] Event Mask on line 4
        EM4: u1 = 0,
        /// [5:6] Event Mask on line 5
        EM5: u1 = 0,
        /// [6:7] Event Mask on line 6
        EM6: u1 = 0,
        /// [7:8] Event Mask on line 7
        EM7: u1 = 0,
        /// [8:9] Event Mask on line 8
        EM8: u1 = 0,
        /// [9:10] Event Mask on line 9
        EM9: u1 = 0,
        /// [10:11] Event Mask on line 10
        EM10: u1 = 0,
        /// [11:12] Event Mask on line 11
        EM11: u1 = 0,
        /// [12:13] Event Mask on line 12
        EM12: u1 = 0,
        /// [13:14] Event Mask on line 13
        EM13: u1 = 0,
        /// [14:15] Event Mask on line 14
        EM14: u1 = 0,
        /// [15:16] Event Mask on line 15
        EM15: u1 = 0,
        /// [16:17] Event Mask on line 16
        EM16: u1 = 0,
        /// [17:18] Event Mask on line 17
        EM17: u1 = 0,
        /// [18:19] Event Mask on line 18
        EM18: u1 = 0,
        /// [19:20] Event Mask on line 19
        EM19: u1 = 0,
        /// [20:21] Event Mask on line 20
        EM20: u1 = 0,
        /// [21:22] Event Mask on line 21
        EM21: u1 = 0,
        /// [22:23] Event Mask on line 22
        EM22: u1 = 0,
        /// [23:24] Event Mask on line 23
        EM23: u1 = 0,
        /// [24:25] Event Mask on line 24
        EM24: u1 = 0,
        /// [25:26] Event Mask on line 25
        EM25: u1 = 0,
        /// [26:27] Event Mask on line 26
        EM26: u1 = 0,
        _unused27: u1 = 0,
        /// [28:29] Event Mask on line 28
        EM28: u1 = 0,
        /// [29:30] Event Mask on line 29
        EM29: u1 = 0,
        _unused30: u2 = 0,
    }),
    /// [+0x08] Rising Trigger selection register (EXTI_RTSR)
    RTSR: r32(packed struct {
        /// [0:1] Rising trigger event configuration of line 0
        RT0: u1 = 0,
        /// [1:2] Rising trigger event configuration of line 1
        RT1: u1 = 0,
        /// [2:3] Rising trigger event configuration of line 2
        RT2: u1 = 0,
        /// [3:4] Rising trigger event configuration of line 3
        RT3: u1 = 0,
        /// [4:5] Rising trigger event configuration of line 4
        RT4: u1 = 0,
        /// [5:6] Rising trigger event configuration of line 5
        RT5: u1 = 0,
        /// [6:7] Rising trigger event configuration of line 6
        RT6: u1 = 0,
        /// [7:8] Rising trigger event configuration of line 7
        RT7: u1 = 0,
        /// [8:9] Rising trigger event configuration of line 8
        RT8: u1 = 0,
        /// [9:10] Rising trigger event configuration of line 9
        RT9: u1 = 0,
        /// [10:11] Rising trigger event configuration of line 10
        RT10: u1 = 0,
        /// [11:12] Rising trigger event configuration of line 11
        RT11: u1 = 0,
        /// [12:13] Rising trigger event configuration of line 12
        RT12: u1 = 0,
        /// [13:14] Rising trigger event configuration of line 13
        RT13: u1 = 0,
        /// [14:15] Rising trigger event configuration of line 14
        RT14: u1 = 0,
        /// [15:16] Rising trigger event configuration of line 15
        RT15: u1 = 0,
        /// [16:17] Rising trigger event configuration of line 16
        RT16: u1 = 0,
        /// [17:18] Rising trigger event configuration of line 17
        RT17: u1 = 0,
        _unused18: u1 = 0,
        /// [19:20] Rising trigger event configuration of line 19
        RT19: u1 = 0,
        /// [20:21] Rising trigger event configuration of line 20
        RT20: u1 = 0,
        /// [21:22] Rising trigger event configuration of line 21
        RT21: u1 = 0,
        /// [22:23] Rising trigger event configuration of line 22
        RT22: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x0C] Falling Trigger selection register (EXTI_FTSR)
    FTSR: r32(packed struct {
        /// [0:1] Falling trigger event configuration of line 0
        FT0: u1 = 0,
        /// [1:2] Falling trigger event configuration of line 1
        FT1: u1 = 0,
        /// [2:3] Falling trigger event configuration of line 2
        FT2: u1 = 0,
        /// [3:4] Falling trigger event configuration of line 3
        FT3: u1 = 0,
        /// [4:5] Falling trigger event configuration of line 4
        FT4: u1 = 0,
        /// [5:6] Falling trigger event configuration of line 5
        FT5: u1 = 0,
        /// [6:7] Falling trigger event configuration of line 6
        FT6: u1 = 0,
        /// [7:8] Falling trigger event configuration of line 7
        FT7: u1 = 0,
        /// [8:9] Falling trigger event configuration of line 8
        FT8: u1 = 0,
        /// [9:10] Falling trigger event configuration of line 9
        FT9: u1 = 0,
        /// [10:11] Falling trigger event configuration of line 10
        FT10: u1 = 0,
        /// [11:12] Falling trigger event configuration of line 11
        FT11: u1 = 0,
        /// [12:13] Falling trigger event configuration of line 12
        FT12: u1 = 0,
        /// [13:14] Falling trigger event configuration of line 13
        FT13: u1 = 0,
        /// [14:15] Falling trigger event configuration of line 14
        FT14: u1 = 0,
        /// [15:16] Falling trigger event configuration of line 15
        FT15: u1 = 0,
        /// [16:17] Falling trigger event configuration of line 16
        FT16: u1 = 0,
        /// [17:18] Falling trigger event configuration of line 17
        FT17: u1 = 0,
        _unused18: u1 = 0,
        /// [19:20] Falling trigger event configuration of line 19
        FT19: u1 = 0,
        /// [20:21] Falling trigger event configuration of line 20
        FT20: u1 = 0,
        /// [21:22] Falling trigger event configuration of line 21
        FT21: u1 = 0,
        /// [22:23] Falling trigger event configuration of line 22
        FT22: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x10] Software interrupt event register (EXTI_SWIER)
    SWIER: r32(packed struct {
        /// [0:1] Software Interrupt on line 0
        SWI0: u1 = 0,
        /// [1:2] Software Interrupt on line 1
        SWI1: u1 = 0,
        /// [2:3] Software Interrupt on line 2
        SWI2: u1 = 0,
        /// [3:4] Software Interrupt on line 3
        SWI3: u1 = 0,
        /// [4:5] Software Interrupt on line 4
        SWI4: u1 = 0,
        /// [5:6] Software Interrupt on line 5
        SWI5: u1 = 0,
        /// [6:7] Software Interrupt on line 6
        SWI6: u1 = 0,
        /// [7:8] Software Interrupt on line 7
        SWI7: u1 = 0,
        /// [8:9] Software Interrupt on line 8
        SWI8: u1 = 0,
        /// [9:10] Software Interrupt on line 9
        SWI9: u1 = 0,
        /// [10:11] Software Interrupt on line 10
        SWI10: u1 = 0,
        /// [11:12] Software Interrupt on line 11
        SWI11: u1 = 0,
        /// [12:13] Software Interrupt on line 12
        SWI12: u1 = 0,
        /// [13:14] Software Interrupt on line 13
        SWI13: u1 = 0,
        /// [14:15] Software Interrupt on line 14
        SWI14: u1 = 0,
        /// [15:16] Software Interrupt on line 15
        SWI15: u1 = 0,
        /// [16:17] Software Interrupt on line 16
        SWI16: u1 = 0,
        /// [17:18] Software Interrupt on line 17
        SWI17: u1 = 0,
        _unused18: u1 = 0,
        /// [19:20] Software Interrupt on line 19
        SWI19: u1 = 0,
        /// [20:21] Software Interrupt on line 20
        SWI20: u1 = 0,
        /// [21:22] Software Interrupt on line 21
        SWI21: u1 = 0,
        /// [22:23] Software Interrupt on line 22
        SWI22: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x14] Pending register (EXTI_PR)
    PR: r32(packed struct {
        /// [0:1] Pending bit 0
        PIF0: u1 = 0,
        /// [1:2] Pending bit 1
        PIF1: u1 = 0,
        /// [2:3] Pending bit 2
        PIF2: u1 = 0,
        /// [3:4] Pending bit 3
        PIF3: u1 = 0,
        /// [4:5] Pending bit 4
        PIF4: u1 = 0,
        /// [5:6] Pending bit 5
        PIF5: u1 = 0,
        /// [6:7] Pending bit 6
        PIF6: u1 = 0,
        /// [7:8] Pending bit 7
        PIF7: u1 = 0,
        /// [8:9] Pending bit 8
        PIF8: u1 = 0,
        /// [9:10] Pending bit 9
        PIF9: u1 = 0,
        /// [10:11] Pending bit 10
        PIF10: u1 = 0,
        /// [11:12] Pending bit 11
        PIF11: u1 = 0,
        /// [12:13] Pending bit 12
        PIF12: u1 = 0,
        /// [13:14] Pending bit 13
        PIF13: u1 = 0,
        /// [14:15] Pending bit 14
        PIF14: u1 = 0,
        /// [15:16] Pending bit 15
        PIF15: u1 = 0,
        /// [16:17] Pending bit 16
        PIF16: u1 = 0,
        /// [17:18] Pending bit 17
        PIF17: u1 = 0,
        _unused18: u1 = 0,
        /// [19:20] Pending bit 19
        PIF19: u1 = 0,
        /// [20:21] Pending bit 20
        PIF20: u1 = 0,
        /// [21:22] Pending bit 21
        PIF21: u1 = 0,
        /// [22:23] Pending bit 22
        PIF22: u1 = 0,
        _unused23: u9 = 0,
    }),
};

/// Firewall
pub const FIREWALL_Peripheral = packed struct {
    /// [+0x00] Code segment start address
    CSSA: r32(packed struct {
        _unused0: u8 = 0,
        /// [8:24] code segment start address
        ADD: u16 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x04] Code segment length
    CSL: r32(packed struct {
        _unused0: u8 = 0,
        /// [8:22] code segment length
        LENG: u14 = 0,
        _unused22: u10 = 0,
    }),
    /// [+0x08] Non-volatile data segment start address
    NVDSSA: r32(packed struct {
        _unused0: u8 = 0,
        /// [8:24] Non-volatile data segment start address
        ADD: u16 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x0C] Non-volatile data segment length
    NVDSL: r32(packed struct {
        _unused0: u8 = 0,
        /// [8:22] Non-volatile data segment length
        LENG: u14 = 0,
        _unused22: u10 = 0,
    }),
    /// [+0x10] Volatile data segment start address
    VDSSA: r32(packed struct {
        _unused0: u6 = 0,
        /// [6:16] Volatile data segment start address
        ADD: u10 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] Volatile data segment length
    VDSL: r32(packed struct {
        _unused0: u6 = 0,
        /// [6:16] Non-volatile data segment length
        LENG: u10 = 0,
        _unused16: u16 = 0,
    }),
    _unused24: [8]u8,
    /// [+0x20] Configuration register
    CR: r32(packed struct {
        /// [0:1] Firewall pre alarm
        FPA: u1 = 0,
        /// [1:2] Volatile data shared
        VDS: u1 = 0,
        /// [2:3] Volatile data execution
        VDE: u1 = 0,
        _unused3: u29 = 0,
    }),
};

/// Flash
pub const FLASH_Peripheral = packed struct {
    /// [+0x00] Access control register
    ACR: r32(packed struct {
        /// [0:1] Latency
        LATENCY: u1 = 0,
        /// [1:2] Prefetch enable
        PRFTEN: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] Flash mode during Sleep
        SLEEP_PD: u1 = 0,
        /// [4:5] Flash mode during Run
        RUN_PD: u1 = 0,
        /// [5:6] Disable Buffer
        DESAB_BUF: u1 = 0,
        /// [6:7] Pre-read data address
        PRE_READ: u1 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x04] Program/erase control register
    PECR: r32(packed struct {
        /// [0:1] FLASH_PECR and data EEPROM lock
        PELOCK: u1 = 0,
        /// [1:2] Program memory lock
        PRGLOCK: u1 = 0,
        /// [2:3] Option bytes block lock
        OPTLOCK: u1 = 0,
        /// [3:4] Program memory selection
        PROG: u1 = 0,
        /// [4:5] Data EEPROM selection
        DATA: u1 = 0,
        _unused5: u3 = 0,
        /// [8:9] Fixed time data write for Byte, Half Word and Word programming
        FTDW: u1 = 0,
        /// [9:10] Page or Double Word erase mode
        ERASE: u1 = 0,
        /// [10:11] Half Page/Double Word programming mode
        FPRG: u1 = 0,
        _unused11: u4 = 0,
        /// [15:16] Parallel bank mode
        PARALLELBANK: u1 = 0,
        /// [16:17] End of programming interrupt enable
        EOPIE: u1 = 0,
        /// [17:18] Error interrupt enable
        ERRIE: u1 = 0,
        /// [18:19] Launch the option byte loading
        OBL_LAUNCH: u1 = 0,
        _unused19: u13 = 0,
    }),
    /// [+0x08] Power down key register
    PDKEYR: u32,
    /// [+0x0C] Program/erase key register
    PEKEYR: u32,
    /// [+0x10] Program memory key register
    PRGKEYR: u32,
    /// [+0x14] Option byte key register
    OPTKEYR: u32,
    /// [+0x18] Status register
    SR: r32(packed struct {
        /// [0:1] Write/erase operations in progress
        BSY: u1 = 0,
        /// [1:2] End of operation
        EOP: u1 = 0,
        /// [2:3] End of high voltage
        ENDHV: u1 = 0,
        /// [3:4] Flash memory module ready after low power mode
        READY: u1 = 0,
        _unused4: u4 = 0,
        /// [8:9] Write protected error
        WRPERR: u1 = 0,
        /// [9:10] Programming alignment error
        PGAERR: u1 = 0,
        /// [10:11] Size error
        SIZERR: u1 = 0,
        /// [11:12] Option validity error
        OPTVERR: u1 = 0,
        _unused12: u2 = 0,
        /// [14:15] RDERR
        RDERR: u1 = 0,
        _unused15: u1 = 0,
        /// [16:17] NOTZEROERR
        NOTZEROERR: u1 = 0,
        /// [17:18] FWWERR
        FWWERR: u1 = 0,
        _unused18: u14 = 0,
    }),
    /// [+0x1C] Option byte register
    OBR: r32(packed struct {
        /// [0:8] Read protection
        RDPRT: u8 = 0,
        /// [8:9] Selection of protection mode of WPR bits
        SPRMOD: u1 = 0,
        _unused9: u7 = 0,
        /// [16:20] BOR_LEV
        BOR_LEV: u4 = 0,
        _unused20: u12 = 0,
    }),
    /// [+0x20] Write protection register
    WRPR: r32(packed struct {
        /// [0:16] Write protection
        WRP: u16 = 0,
        _unused16: u16 = 0,
    }),
};

/// General-purpose I/Os
pub const GPIO_Peripheral = packed struct {
    /// [+0x00] GPIO port mode register
    MODER: r32(packed struct {
        /// [0:2] Port x configuration bits (y = 0..15)
        MODE0: u2 = 0,
        /// [2:4] Port x configuration bits (y = 0..15)
        MODE1: u2 = 0,
        /// [4:6] Port x configuration bits (y = 0..15)
        MODE2: u2 = 0,
        /// [6:8] Port x configuration bits (y = 0..15)
        MODE3: u2 = 0,
        /// [8:10] Port x configuration bits (y = 0..15)
        MODE4: u2 = 0,
        /// [10:12] Port x configuration bits (y = 0..15)
        MODE5: u2 = 0,
        /// [12:14] Port x configuration bits (y = 0..15)
        MODE6: u2 = 0,
        /// [14:16] Port x configuration bits (y = 0..15)
        MODE7: u2 = 0,
        /// [16:18] Port x configuration bits (y = 0..15)
        MODE8: u2 = 0,
        /// [18:20] Port x configuration bits (y = 0..15)
        MODE9: u2 = 0,
        /// [20:22] Port x configuration bits (y = 0..15)
        MODE10: u2 = 0,
        /// [22:24] Port x configuration bits (y = 0..15)
        MODE11: u2 = 0,
        /// [24:26] Port x configuration bits (y = 0..15)
        MODE12: u2 = 0,
        /// [26:28] Port x configuration bits (y = 0..15)
        MODE13: u2 = 0,
        /// [28:30] Port x configuration bits (y = 0..15)
        MODE14: u2 = 0,
        /// [30:32] Port x configuration bits (y = 0..15)
        MODE15: u2 = 0,
    }),
    /// [+0x04] GPIO port output type register
    OTYPER: r32(packed struct {
        /// [0:1] Port x configuration bits (y = 0..15)
        OT0: u1 = 0,
        /// [1:2] Port x configuration bits (y = 0..15)
        OT1: u1 = 0,
        /// [2:3] Port x configuration bits (y = 0..15)
        OT2: u1 = 0,
        /// [3:4] Port x configuration bits (y = 0..15)
        OT3: u1 = 0,
        /// [4:5] Port x configuration bits (y = 0..15)
        OT4: u1 = 0,
        /// [5:6] Port x configuration bits (y = 0..15)
        OT5: u1 = 0,
        /// [6:7] Port x configuration bits (y = 0..15)
        OT6: u1 = 0,
        /// [7:8] Port x configuration bits (y = 0..15)
        OT7: u1 = 0,
        /// [8:9] Port x configuration bits (y = 0..15)
        OT8: u1 = 0,
        /// [9:10] Port x configuration bits (y = 0..15)
        OT9: u1 = 0,
        /// [10:11] Port x configuration bits (y = 0..15)
        OT10: u1 = 0,
        /// [11:12] Port x configuration bits (y = 0..15)
        OT11: u1 = 0,
        /// [12:13] Port x configuration bits (y = 0..15)
        OT12: u1 = 0,
        /// [13:14] Port x configuration bits (y = 0..15)
        OT13: u1 = 0,
        /// [14:15] Port x configuration bits (y = 0..15)
        OT14: u1 = 0,
        /// [15:16] Port x configuration bits (y = 0..15)
        OT15: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x08] GPIO port output speed register
    OSPEEDR: r32(packed struct {
        /// [0:2] Port x configuration bits (y = 0..15)
        OSPEED0: u2 = 0,
        /// [2:4] Port x configuration bits (y = 0..15)
        OSPEED1: u2 = 0,
        /// [4:6] Port x configuration bits (y = 0..15)
        OSPEED2: u2 = 0,
        /// [6:8] Port x configuration bits (y = 0..15)
        OSPEED3: u2 = 0,
        /// [8:10] Port x configuration bits (y = 0..15)
        OSPEED4: u2 = 0,
        /// [10:12] Port x configuration bits (y = 0..15)
        OSPEED5: u2 = 0,
        /// [12:14] Port x configuration bits (y = 0..15)
        OSPEED6: u2 = 0,
        /// [14:16] Port x configuration bits (y = 0..15)
        OSPEED7: u2 = 0,
        /// [16:18] Port x configuration bits (y = 0..15)
        OSPEED8: u2 = 0,
        /// [18:20] Port x configuration bits (y = 0..15)
        OSPEED9: u2 = 0,
        /// [20:22] Port x configuration bits (y = 0..15)
        OSPEED10: u2 = 0,
        /// [22:24] Port x configuration bits (y = 0..15)
        OSPEED11: u2 = 0,
        /// [24:26] Port x configuration bits (y = 0..15)
        OSPEED12: u2 = 0,
        /// [26:28] Port x configuration bits (y = 0..15)
        OSPEED13: u2 = 0,
        /// [28:30] Port x configuration bits (y = 0..15)
        OSPEED14: u2 = 0,
        /// [30:32] Port x configuration bits (y = 0..15)
        OSPEED15: u2 = 0,
    }),
    /// [+0x0C] GPIO port pull-up/pull-down register
    PUPDR: r32(packed struct {
        /// [0:2] Port x configuration bits (y = 0..15)
        PUPD0: u2 = 0,
        /// [2:4] Port x configuration bits (y = 0..15)
        PUPD1: u2 = 0,
        /// [4:6] Port x configuration bits (y = 0..15)
        PUPD2: u2 = 0,
        /// [6:8] Port x configuration bits (y = 0..15)
        PUPD3: u2 = 0,
        /// [8:10] Port x configuration bits (y = 0..15)
        PUPD4: u2 = 0,
        /// [10:12] Port x configuration bits (y = 0..15)
        PUPD5: u2 = 0,
        /// [12:14] Port x configuration bits (y = 0..15)
        PUPD6: u2 = 0,
        /// [14:16] Port x configuration bits (y = 0..15)
        PUPD7: u2 = 0,
        /// [16:18] Port x configuration bits (y = 0..15)
        PUPD8: u2 = 0,
        /// [18:20] Port x configuration bits (y = 0..15)
        PUPD9: u2 = 0,
        /// [20:22] Port x configuration bits (y = 0..15)
        PUPD10: u2 = 0,
        /// [22:24] Port x configuration bits (y = 0..15)
        PUPD11: u2 = 0,
        /// [24:26] Port x configuration bits (y = 0..15)
        PUPD12: u2 = 0,
        /// [26:28] Port x configuration bits (y = 0..15)
        PUPD13: u2 = 0,
        /// [28:30] Port x configuration bits (y = 0..15)
        PUPD14: u2 = 0,
        /// [30:32] Port x configuration bits (y = 0..15)
        PUPD15: u2 = 0,
    }),
    /// [+0x10] GPIO port input data register
    IDR: r32(packed struct {
        /// [0:1] Port input data bit (y = 0..15)
        ID0: u1 = 0,
        /// [1:2] Port input data bit (y = 0..15)
        ID1: u1 = 0,
        /// [2:3] Port input data bit (y = 0..15)
        ID2: u1 = 0,
        /// [3:4] Port input data bit (y = 0..15)
        ID3: u1 = 0,
        /// [4:5] Port input data bit (y = 0..15)
        ID4: u1 = 0,
        /// [5:6] Port input data bit (y = 0..15)
        ID5: u1 = 0,
        /// [6:7] Port input data bit (y = 0..15)
        ID6: u1 = 0,
        /// [7:8] Port input data bit (y = 0..15)
        ID7: u1 = 0,
        /// [8:9] Port input data bit (y = 0..15)
        ID8: u1 = 0,
        /// [9:10] Port input data bit (y = 0..15)
        ID9: u1 = 0,
        /// [10:11] Port input data bit (y = 0..15)
        ID10: u1 = 0,
        /// [11:12] Port input data bit (y = 0..15)
        ID11: u1 = 0,
        /// [12:13] Port input data bit (y = 0..15)
        ID12: u1 = 0,
        /// [13:14] Port input data bit (y = 0..15)
        ID13: u1 = 0,
        /// [14:15] Port input data bit (y = 0..15)
        ID14: u1 = 0,
        /// [15:16] Port input data bit (y = 0..15)
        ID15: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] GPIO port output data register
    ODR: r32(packed struct {
        /// [0:1] Port output data bit (y = 0..15)
        OD0: u1 = 0,
        /// [1:2] Port output data bit (y = 0..15)
        OD1: u1 = 0,
        /// [2:3] Port output data bit (y = 0..15)
        OD2: u1 = 0,
        /// [3:4] Port output data bit (y = 0..15)
        OD3: u1 = 0,
        /// [4:5] Port output data bit (y = 0..15)
        OD4: u1 = 0,
        /// [5:6] Port output data bit (y = 0..15)
        OD5: u1 = 0,
        /// [6:7] Port output data bit (y = 0..15)
        OD6: u1 = 0,
        /// [7:8] Port output data bit (y = 0..15)
        OD7: u1 = 0,
        /// [8:9] Port output data bit (y = 0..15)
        OD8: u1 = 0,
        /// [9:10] Port output data bit (y = 0..15)
        OD9: u1 = 0,
        /// [10:11] Port output data bit (y = 0..15)
        OD10: u1 = 0,
        /// [11:12] Port output data bit (y = 0..15)
        OD11: u1 = 0,
        /// [12:13] Port output data bit (y = 0..15)
        OD12: u1 = 0,
        /// [13:14] Port output data bit (y = 0..15)
        OD13: u1 = 0,
        /// [14:15] Port output data bit (y = 0..15)
        OD14: u1 = 0,
        /// [15:16] Port output data bit (y = 0..15)
        OD15: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x18] GPIO port bit set/reset register
    BSRR: r32(packed struct {
        /// [0:1] Port x set bit y (y= 0..15)
        BS0: u1 = 0,
        /// [1:2] Port x set bit y (y= 0..15)
        BS1: u1 = 0,
        /// [2:3] Port x set bit y (y= 0..15)
        BS2: u1 = 0,
        /// [3:4] Port x set bit y (y= 0..15)
        BS3: u1 = 0,
        /// [4:5] Port x set bit y (y= 0..15)
        BS4: u1 = 0,
        /// [5:6] Port x set bit y (y= 0..15)
        BS5: u1 = 0,
        /// [6:7] Port x set bit y (y= 0..15)
        BS6: u1 = 0,
        /// [7:8] Port x set bit y (y= 0..15)
        BS7: u1 = 0,
        /// [8:9] Port x set bit y (y= 0..15)
        BS8: u1 = 0,
        /// [9:10] Port x set bit y (y= 0..15)
        BS9: u1 = 0,
        /// [10:11] Port x set bit y (y= 0..15)
        BS10: u1 = 0,
        /// [11:12] Port x set bit y (y= 0..15)
        BS11: u1 = 0,
        /// [12:13] Port x set bit y (y= 0..15)
        BS12: u1 = 0,
        /// [13:14] Port x set bit y (y= 0..15)
        BS13: u1 = 0,
        /// [14:15] Port x set bit y (y= 0..15)
        BS14: u1 = 0,
        /// [15:16] Port x set bit y (y= 0..15)
        BS15: u1 = 0,
        /// [16:17] Port x reset bit y (y = 0..15)
        BR0: u1 = 0,
        /// [17:18] Port x reset bit y (y = 0..15)
        BR1: u1 = 0,
        /// [18:19] Port x reset bit y (y = 0..15)
        BR2: u1 = 0,
        /// [19:20] Port x reset bit y (y = 0..15)
        BR3: u1 = 0,
        /// [20:21] Port x reset bit y (y = 0..15)
        BR4: u1 = 0,
        /// [21:22] Port x reset bit y (y = 0..15)
        BR5: u1 = 0,
        /// [22:23] Port x reset bit y (y = 0..15)
        BR6: u1 = 0,
        /// [23:24] Port x reset bit y (y = 0..15)
        BR7: u1 = 0,
        /// [24:25] Port x reset bit y (y = 0..15)
        BR8: u1 = 0,
        /// [25:26] Port x reset bit y (y = 0..15)
        BR9: u1 = 0,
        /// [26:27] Port x reset bit y (y = 0..15)
        BR10: u1 = 0,
        /// [27:28] Port x reset bit y (y = 0..15)
        BR11: u1 = 0,
        /// [28:29] Port x reset bit y (y = 0..15)
        BR12: u1 = 0,
        /// [29:30] Port x reset bit y (y = 0..15)
        BR13: u1 = 0,
        /// [30:31] Port x reset bit y (y = 0..15)
        BR14: u1 = 0,
        /// [31:32] Port x reset bit y (y = 0..15)
        BR15: u1 = 0,
    }),
    /// [+0x1C] GPIO port configuration lock register
    LCKR: r32(packed struct {
        /// [0:1] Port x lock bit y (y= 0..15)
        LCK0: u1 = 0,
        /// [1:2] Port x lock bit y (y= 0..15)
        LCK1: u1 = 0,
        /// [2:3] Port x lock bit y (y= 0..15)
        LCK2: u1 = 0,
        /// [3:4] Port x lock bit y (y= 0..15)
        LCK3: u1 = 0,
        /// [4:5] Port x lock bit y (y= 0..15)
        LCK4: u1 = 0,
        /// [5:6] Port x lock bit y (y= 0..15)
        LCK5: u1 = 0,
        /// [6:7] Port x lock bit y (y= 0..15)
        LCK6: u1 = 0,
        /// [7:8] Port x lock bit y (y= 0..15)
        LCK7: u1 = 0,
        /// [8:9] Port x lock bit y (y= 0..15)
        LCK8: u1 = 0,
        /// [9:10] Port x lock bit y (y= 0..15)
        LCK9: u1 = 0,
        /// [10:11] Port x lock bit y (y= 0..15)
        LCK10: u1 = 0,
        /// [11:12] Port x lock bit y (y= 0..15)
        LCK11: u1 = 0,
        /// [12:13] Port x lock bit y (y= 0..15)
        LCK12: u1 = 0,
        /// [13:14] Port x lock bit y (y= 0..15)
        LCK13: u1 = 0,
        /// [14:15] Port x lock bit y (y= 0..15)
        LCK14: u1 = 0,
        /// [15:16] Port x lock bit y (y= 0..15)
        LCK15: u1 = 0,
        /// [16:17] Port x lock bit y (y= 0..15)
        LCKK: u1 = 0,
        _unused17: u15 = 0,
    }),
    /// [+0x20] GPIO alternate function low register
    AFRL: r32(packed struct {
        /// [0:4] Alternate function selection for port x pin y (y = 0..7)
        AFSEL0: u4 = 0,
        /// [4:8] Alternate function selection for port x pin y (y = 0..7)
        AFSEL1: u4 = 0,
        /// [8:12] Alternate function selection for port x pin y (y = 0..7)
        AFSEL2: u4 = 0,
        /// [12:16] Alternate function selection for port x pin y (y = 0..7)
        AFSEL3: u4 = 0,
        /// [16:20] Alternate function selection for port x pin y (y = 0..7)
        AFSEL4: u4 = 0,
        /// [20:24] Alternate function selection for port x pin y (y = 0..7)
        AFSEL5: u4 = 0,
        /// [24:28] Alternate function selection for port x pin y (y = 0..7)
        AFSEL6: u4 = 0,
        /// [28:32] Alternate function selection for port x pin y (y = 0..7)
        AFSEL7: u4 = 0,
    }),
    /// [+0x24] GPIO alternate function high register
    AFRH: r32(packed struct {
        /// [0:4] Alternate function selection for port x pin y (y = 8..15)
        AFSEL8: u4 = 0,
        /// [4:8] Alternate function selection for port x pin y (y = 8..15)
        AFSEL9: u4 = 0,
        /// [8:12] Alternate function selection for port x pin y (y = 8..15)
        AFSEL10: u4 = 0,
        /// [12:16] Alternate function selection for port x pin y (y = 8..15)
        AFSEL11: u4 = 0,
        /// [16:20] Alternate function selection for port x pin y (y = 8..15)
        AFSEL12: u4 = 0,
        /// [20:24] Alternate function selection for port x pin y (y = 8..15)
        AFSEL13: u4 = 0,
        /// [24:28] Alternate function selection for port x pin y (y = 8..15)
        AFSEL14: u4 = 0,
        /// [28:32] Alternate function selection for port x pin y (y = 8..15)
        AFSEL15: u4 = 0,
    }),
    /// [+0x28] GPIO port bit reset register
    BRR: r32(packed struct {
        /// [0:1] Port x Reset bit y (y= 0 .. 15)
        BR0: u1 = 0,
        /// [1:2] Port x Reset bit y (y= 0 .. 15)
        BR1: u1 = 0,
        /// [2:3] Port x Reset bit y (y= 0 .. 15)
        BR2: u1 = 0,
        /// [3:4] Port x Reset bit y (y= 0 .. 15)
        BR3: u1 = 0,
        /// [4:5] Port x Reset bit y (y= 0 .. 15)
        BR4: u1 = 0,
        /// [5:6] Port x Reset bit y (y= 0 .. 15)
        BR5: u1 = 0,
        /// [6:7] Port x Reset bit y (y= 0 .. 15)
        BR6: u1 = 0,
        /// [7:8] Port x Reset bit y (y= 0 .. 15)
        BR7: u1 = 0,
        /// [8:9] Port x Reset bit y (y= 0 .. 15)
        BR8: u1 = 0,
        /// [9:10] Port x Reset bit y (y= 0 .. 15)
        BR9: u1 = 0,
        /// [10:11] Port x Reset bit y (y= 0 .. 15)
        BR10: u1 = 0,
        /// [11:12] Port x Reset bit y (y= 0 .. 15)
        BR11: u1 = 0,
        /// [12:13] Port x Reset bit y (y= 0 .. 15)
        BR12: u1 = 0,
        /// [13:14] Port x Reset bit y (y= 0 .. 15)
        BR13: u1 = 0,
        /// [14:15] Port x Reset bit y (y= 0 .. 15)
        BR14: u1 = 0,
        /// [15:16] Port x Reset bit y (y= 0 .. 15)
        BR15: u1 = 0,
        _unused16: u16 = 0,
    }),
};

/// Inter-integrated circuit
pub const I2C_Peripheral = packed struct {
    /// [+0x00] Control register 1
    CR1: r32(packed struct {
        /// [0:1] Peripheral enable
        PE: u1 = 0,
        /// [1:2] TX Interrupt enable
        TXIE: u1 = 0,
        /// [2:3] RX Interrupt enable
        RXIE: u1 = 0,
        /// [3:4] Address match interrupt enable (slave only)
        ADDRIE: u1 = 0,
        /// [4:5] Not acknowledge received interrupt enable
        NACKIE: u1 = 0,
        /// [5:6] STOP detection Interrupt enable
        STOPIE: u1 = 0,
        /// [6:7] Transfer Complete interrupt enable
        TCIE: u1 = 0,
        /// [7:8] Error interrupts enable
        ERRIE: u1 = 0,
        /// [8:12] Digital noise filter
        DNF: u4 = 0,
        /// [12:13] Analog noise filter OFF
        ANFOFF: u1 = 0,
        _unused13: u1 = 0,
        /// [14:15] DMA transmission requests enable
        TXDMAEN: u1 = 0,
        /// [15:16] DMA reception requests enable
        RXDMAEN: u1 = 0,
        /// [16:17] Slave byte control
        SBC: u1 = 0,
        /// [17:18] Clock stretching disable
        NOSTRETCH: u1 = 0,
        /// [18:19] Wakeup from STOP enable
        WUPEN: u1 = 0,
        /// [19:20] General call enable
        GCEN: u1 = 0,
        /// [20:21] SMBus Host address enable
        SMBHEN: u1 = 0,
        /// [21:22] SMBus Device Default address enable
        SMBDEN: u1 = 0,
        /// [22:23] SMBUS alert enable
        ALERTEN: u1 = 0,
        /// [23:24] PEC enable
        PECEN: u1 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x04] Control register 2
    CR2: r32(packed struct {
        /// [0:10] Slave address bit (master mode)
        SADD: u10 = 0,
        /// [10:11] Transfer direction (master mode)
        RD_WRN: u1 = 0,
        /// [11:12] 10-bit addressing mode (master mode)
        ADD10: u1 = 0,
        /// [12:13] 10-bit address header only read direction (master receiver mode)
        HEAD10R: u1 = 0,
        /// [13:14] Start generation
        START: u1 = 0,
        /// [14:15] Stop generation (master mode)
        STOP: u1 = 0,
        /// [15:16] NACK generation (slave mode)
        NACK: u1 = 0,
        /// [16:24] Number of bytes
        NBYTES: u8 = 0,
        /// [24:25] NBYTES reload mode
        RELOAD: u1 = 0,
        /// [25:26] Automatic end mode (master mode)
        AUTOEND: u1 = 0,
        /// [26:27] Packet error checking byte
        PECBYTE: u1 = 0,
        _unused27: u5 = 0,
    }),
    /// [+0x08] Own address register 1
    OAR1: r32(packed struct {
        /// [0:10] Interface address
        OA1: u10 = 0,
        /// [10:11] Own Address 1 10-bit mode
        OA1MODE: u1 = 0,
        _unused11: u4 = 0,
        /// [15:16] Own Address 1 enable
        OA1EN: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x0C] Own address register 2
    OAR2: r32(packed struct {
        _unused0: u1 = 0,
        /// [1:8] Interface address
        OA2: u7 = 0,
        /// [8:11] Own Address 2 masks
        OA2MSK: u3 = 0,
        _unused11: u4 = 0,
        /// [15:16] Own Address 2 enable
        OA2EN: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] Timing register
    TIMINGR: r32(packed struct {
        /// [0:8] SCL low period (master mode)
        SCLL: u8 = 0,
        /// [8:16] SCL high period (master mode)
        SCLH: u8 = 0,
        /// [16:20] Data hold time
        SDADEL: u4 = 0,
        /// [20:24] Data setup time
        SCLDEL: u4 = 0,
        _unused24: u4 = 0,
        /// [28:32] Timing prescaler
        PRESC: u4 = 0,
    }),
    /// [+0x14] Status register 1
    TIMEOUTR: r32(packed struct {
        /// [0:12] Bus timeout A
        TIMEOUTA: u12 = 0,
        /// [12:13] Idle clock timeout detection
        TIDLE: u1 = 0,
        _unused13: u2 = 0,
        /// [15:16] Clock timeout enable
        TIMOUTEN: u1 = 0,
        /// [16:28] Bus timeout B
        TIMEOUTB: u12 = 0,
        _unused28: u3 = 0,
        /// [31:32] Extended clock timeout enable
        TEXTEN: u1 = 0,
    }),
    /// [+0x18] Interrupt and Status register
    ISR: r32(packed struct {
        /// [0:1] Transmit data register empty (transmitters)
        TXE: u1 = 0,
        /// [1:2] Transmit interrupt status (transmitters)
        TXIS: u1 = 0,
        /// [2:3] Receive data register not empty (receivers)
        RXNE: u1 = 0,
        /// [3:4] Address matched (slave mode)
        ADDR: u1 = 0,
        /// [4:5] Not acknowledge received flag
        NACKF: u1 = 0,
        /// [5:6] Stop detection flag
        STOPF: u1 = 0,
        /// [6:7] Transfer Complete (master mode)
        TC: u1 = 0,
        /// [7:8] Transfer Complete Reload
        TCR: u1 = 0,
        /// [8:9] Bus error
        BERR: u1 = 0,
        /// [9:10] Arbitration lost
        ARLO: u1 = 0,
        /// [10:11] Overrun/Underrun (slave mode)
        OVR: u1 = 0,
        /// [11:12] PEC Error in reception
        PECERR: u1 = 0,
        /// [12:13] Timeout or t_low detection flag
        TIMEOUT: u1 = 0,
        /// [13:14] SMBus alert
        ALERT: u1 = 0,
        _unused14: u1 = 0,
        /// [15:16] Bus busy
        BUSY: u1 = 0,
        /// [16:17] Transfer direction (Slave mode)
        DIR: u1 = 0,
        /// [17:24] Address match code (Slave mode)
        ADDCODE: u7 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x1C] Interrupt clear register
    ICR: r32(packed struct {
        _unused0: u3 = 0,
        /// [3:4] Address Matched flag clear
        ADDRCF: u1 = 0,
        /// [4:5] Not Acknowledge flag clear
        NACKCF: u1 = 0,
        /// [5:6] Stop detection flag clear
        STOPCF: u1 = 0,
        _unused6: u2 = 0,
        /// [8:9] Bus error flag clear
        BERRCF: u1 = 0,
        /// [9:10] Arbitration lost flag clear
        ARLOCF: u1 = 0,
        /// [10:11] Overrun/Underrun flag clear
        OVRCF: u1 = 0,
        /// [11:12] PEC Error flag clear
        PECCF: u1 = 0,
        /// [12:13] Timeout detection flag clear
        TIMOUTCF: u1 = 0,
        /// [13:14] Alert flag clear
        ALERTCF: u1 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x20] PEC register
    PECR: r32(packed struct {
        /// [0:8] Packet error checking register
        PEC: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x24] Receive data register
    RXDR: r32(packed struct {
        /// [0:8] 8-bit receive data
        RXDATA: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x28] Transmit data register
    TXDR: r32(packed struct {
        /// [0:8] 8-bit transmit data
        TXDATA: u8 = 0,
        _unused8: u24 = 0,
    }),
};

/// Independent watchdog
pub const IWDG_Peripheral = packed struct {
    /// [+0x00] Key register
    KR: r32(packed struct {
        /// [0:16] Key value (write only, read 0x0000)
        KEY: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x04] Prescaler register
    PR: r32(packed struct {
        /// [0:3] Prescaler divider
        PR: u3 = 0,
        _unused3: u29 = 0,
    }),
    /// [+0x08] Reload register
    RLR: r32(packed struct {
        /// [0:12] Watchdog counter reload value
        RL: u12 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x0C] Status register
    SR: r32(packed struct {
        /// [0:1] Watchdog prescaler value update
        PVU: u1 = 0,
        /// [1:2] Watchdog counter reload value update
        RVU: u1 = 0,
        /// [2:3] Watchdog counter window value update
        WVU: u1 = 0,
        _unused3: u29 = 0,
    }),
    /// [+0x10] Window register
    WINR: r32(packed struct {
        /// [0:12] Watchdog counter window value
        WIN: u12 = 0,
        _unused12: u20 = 0,
    }),
};

/// Liquid crystal display controller
pub const LCD_Peripheral = packed struct {
    /// [+0x00] control register
    CR: r32(packed struct {
        /// [0:1] LCD controller enable
        LCDEN: u1 = 0,
        /// [1:2] Voltage source selection
        VSEL: u1 = 0,
        /// [2:5] Duty selection
        DUTY: u3 = 0,
        /// [5:7] Bias selector
        BIAS: u2 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x04] frame control register
    FCR: r32(packed struct {
        /// [0:1] High drive enable
        HD: u1 = 0,
        /// [1:2] Start of frame interrupt enable
        SOFIE: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] Update display done interrupt enable
        UDDIE: u1 = 0,
        /// [4:7] Pulse ON duration
        PON: u3 = 0,
        /// [7:10] Dead time duration
        DEAD: u3 = 0,
        /// [10:13] Contrast control
        CC: u3 = 0,
        /// [13:16] Blink frequency selection
        BLINKF: u3 = 0,
        /// [16:18] Blink mode selection
        BLINK: u2 = 0,
        /// [18:22] DIV clock divider
        DIV: u4 = 0,
        /// [22:26] PS 16-bit prescaler
        PS: u4 = 0,
        _unused26: u6 = 0,
    }),
    /// [+0x08] status register
    SR: r32(packed struct {
        /// [0:1] ENS
        ENS: u1 = 0,
        /// [1:2] Start of frame flag
        SOF: u1 = 0,
        /// [2:3] Update display request
        UDR: u1 = 0,
        /// [3:4] Update Display Done
        UDD: u1 = 0,
        /// [4:5] Ready flag
        RDY: u1 = 0,
        /// [5:6] LCD Frame Control Register Synchronization flag
        FCRSF: u1 = 0,
        _unused6: u26 = 0,
    }),
    /// [+0x0C] clear register
    CLR: r32(packed struct {
        _unused0: u1 = 0,
        /// [1:2] Start of frame flag clear
        SOFC: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] Update display done clear
        UDDC: u1 = 0,
        _unused4: u28 = 0,
    }),
    _unused16: u32,
    /// [+0x14] display memory
    RAM_COM0: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        _unused31: u1 = 0,
    }),
    _unused24: u32,
    /// [+0x1C] display memory
    RAM_COM1: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
    _unused32: u32,
    /// [+0x24] display memory
    RAM_COM2: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
    _unused40: u32,
    /// [+0x2C] display memory
    RAM_COM3: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
    _unused48: u32,
    /// [+0x34] display memory
    RAM_COM4: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
    _unused56: u32,
    /// [+0x3C] display memory
    RAM_COM5: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
    _unused64: u32,
    /// [+0x44] display memory
    RAM_COM6: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
    _unused72: u32,
    /// [+0x4C] display memory
    RAM_COM7: r32(packed struct {
        /// [0:1] S00
        S00: u1 = 0,
        /// [1:2] S01
        S01: u1 = 0,
        /// [2:3] S02
        S02: u1 = 0,
        /// [3:4] S03
        S03: u1 = 0,
        /// [4:5] S04
        S04: u1 = 0,
        /// [5:6] S05
        S05: u1 = 0,
        /// [6:7] S06
        S06: u1 = 0,
        /// [7:8] S07
        S07: u1 = 0,
        /// [8:9] S08
        S08: u1 = 0,
        /// [9:10] S09
        S09: u1 = 0,
        /// [10:11] S10
        S10: u1 = 0,
        /// [11:12] S11
        S11: u1 = 0,
        /// [12:13] S12
        S12: u1 = 0,
        /// [13:14] S13
        S13: u1 = 0,
        /// [14:15] S14
        S14: u1 = 0,
        /// [15:16] S15
        S15: u1 = 0,
        /// [16:17] S16
        S16: u1 = 0,
        /// [17:18] S17
        S17: u1 = 0,
        /// [18:19] S18
        S18: u1 = 0,
        /// [19:20] S19
        S19: u1 = 0,
        /// [20:21] S20
        S20: u1 = 0,
        /// [21:22] S21
        S21: u1 = 0,
        /// [22:23] S22
        S22: u1 = 0,
        /// [23:24] S23
        S23: u1 = 0,
        /// [24:25] S24
        S24: u1 = 0,
        /// [25:26] S25
        S25: u1 = 0,
        /// [26:27] S26
        S26: u1 = 0,
        /// [27:28] S27
        S27: u1 = 0,
        /// [28:29] S28
        S28: u1 = 0,
        /// [29:30] S29
        S29: u1 = 0,
        /// [30:31] S30
        S30: u1 = 0,
        /// [31:32] S31
        S31: u1 = 0,
    }),
};

/// Low power timer
pub const LPTIM_Peripheral = packed struct {
    /// [+0x00] Interrupt and Status Register
    ISR: r32(packed struct {
        /// [0:1] Compare match
        CMPM: u1 = 0,
        /// [1:2] Autoreload match
        ARRM: u1 = 0,
        /// [2:3] External trigger edge event
        EXTTRIG: u1 = 0,
        /// [3:4] Compare register update OK
        CMPOK: u1 = 0,
        /// [4:5] Autoreload register update OK
        ARROK: u1 = 0,
        /// [5:6] Counter direction change down to up
        UP: u1 = 0,
        /// [6:7] Counter direction change up to down
        DOWN: u1 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x04] Interrupt Clear Register
    ICR: r32(packed struct {
        /// [0:1] compare match Clear Flag
        CMPMCF: u1 = 0,
        /// [1:2] Autoreload match Clear Flag
        ARRMCF: u1 = 0,
        /// [2:3] External trigger valid edge Clear Flag
        EXTTRIGCF: u1 = 0,
        /// [3:4] Compare register update OK Clear Flag
        CMPOKCF: u1 = 0,
        /// [4:5] Autoreload register update OK Clear Flag
        ARROKCF: u1 = 0,
        /// [5:6] Direction change to UP Clear Flag
        UPCF: u1 = 0,
        /// [6:7] Direction change to down Clear Flag
        DOWNCF: u1 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x08] Interrupt Enable Register
    IER: r32(packed struct {
        /// [0:1] Compare match Interrupt Enable
        CMPMIE: u1 = 0,
        /// [1:2] Autoreload match Interrupt Enable
        ARRMIE: u1 = 0,
        /// [2:3] External trigger valid edge Interrupt Enable
        EXTTRIGIE: u1 = 0,
        /// [3:4] Compare register update OK Interrupt Enable
        CMPOKIE: u1 = 0,
        /// [4:5] Autoreload register update OK Interrupt Enable
        ARROKIE: u1 = 0,
        /// [5:6] Direction change to UP Interrupt Enable
        UPIE: u1 = 0,
        /// [6:7] Direction change to down Interrupt Enable
        DOWNIE: u1 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x0C] Configuration Register
    CFGR: r32(packed struct {
        /// [0:1] Clock selector
        CKSEL: u1 = 0,
        /// [1:3] Clock Polarity
        CKPOL: u2 = 0,
        /// [3:5] Configurable digital filter for external clock
        CKFLT: u2 = 0,
        _unused5: u1 = 0,
        /// [6:8] Configurable digital filter for trigger
        TRGFLT: u2 = 0,
        _unused8: u1 = 0,
        /// [9:12] Clock prescaler
        PRESC: u3 = 0,
        _unused12: u1 = 0,
        /// [13:16] Trigger selector
        TRIGSEL: u3 = 0,
        _unused16: u1 = 0,
        /// [17:19] Trigger enable and polarity
        TRIGEN: u2 = 0,
        /// [19:20] Timeout enable
        TIMOUT: u1 = 0,
        /// [20:21] Waveform shape
        WAVE: u1 = 0,
        /// [21:22] Waveform shape polarity
        WAVPOL: u1 = 0,
        /// [22:23] Registers update mode
        PRELOAD: u1 = 0,
        /// [23:24] counter mode enabled
        COUNTMODE: u1 = 0,
        /// [24:25] Encoder mode enable
        ENC: u1 = 0,
        _unused25: u7 = 0,
    }),
    /// [+0x10] Control Register
    CR: r32(packed struct {
        /// [0:1] LPTIM Enable
        ENABLE: u1 = 0,
        /// [1:2] LPTIM start in single mode
        SNGSTRT: u1 = 0,
        /// [2:3] Timer start in continuous mode
        CNTSTRT: u1 = 0,
        _unused3: u29 = 0,
    }),
    /// [+0x14] Compare Register
    CMP: r32(packed struct {
        /// [0:16] Compare value.
        CMP: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x18] Autoreload Register
    ARR: r32(packed struct {
        /// [0:16] Auto reload value.
        ARR: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x1C] Counter Register
    CNT: r32(packed struct {
        /// [0:16] Counter value.
        CNT: u16 = 0,
        _unused16: u16 = 0,
    }),
};

/// Universal synchronous asynchronous receiver transmitter
pub const LPUSART_Peripheral = packed struct {
    /// [+0x00] Control register 1
    CR1: r32(packed struct {
        /// [0:1] USART enable
        UE: u1 = 0,
        /// [1:2] USART enable in Stop mode
        UESM: u1 = 0,
        /// [2:3] Receiver enable
        RE: u1 = 0,
        /// [3:4] Transmitter enable
        TE: u1 = 0,
        /// [4:5] IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// [5:6] RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// [6:7] Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// [7:8] interrupt enable
        TXEIE: u1 = 0,
        /// [8:9] PE interrupt enable
        PEIE: u1 = 0,
        /// [9:10] Parity selection
        PS: u1 = 0,
        /// [10:11] Parity control enable
        PCE: u1 = 0,
        /// [11:12] Receiver wakeup method
        WAKE: u1 = 0,
        /// [12:13] Word length
        M0: u1 = 0,
        /// [13:14] Mute mode enable
        MME: u1 = 0,
        /// [14:15] Character match interrupt enable
        CMIE: u1 = 0,
        _unused15: u1 = 0,
        /// [16:17] DEDT0
        DEDT0: u1 = 0,
        /// [17:18] DEDT1
        DEDT1: u1 = 0,
        /// [18:19] DEDT2
        DEDT2: u1 = 0,
        /// [19:20] DEDT3
        DEDT3: u1 = 0,
        /// [20:21] Driver Enable de-assertion time
        DEDT4: u1 = 0,
        /// [21:22] DEAT0
        DEAT0: u1 = 0,
        /// [22:23] DEAT1
        DEAT1: u1 = 0,
        /// [23:24] DEAT2
        DEAT2: u1 = 0,
        /// [24:25] DEAT3
        DEAT3: u1 = 0,
        /// [25:26] Driver Enable assertion time
        DEAT4: u1 = 0,
        _unused26: u2 = 0,
        /// [28:29] Word length
        M1: u1 = 0,
        _unused29: u3 = 0,
    }),
    /// [+0x04] Control register 2
    CR2: r32(packed struct {
        _unused0: u4 = 0,
        /// [4:5] 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        _unused5: u6 = 0,
        /// [11:12] Clock enable
        CLKEN: u1 = 0,
        /// [12:14] STOP bits
        STOP: u2 = 0,
        _unused14: u1 = 0,
        /// [15:16] Swap TX/RX pins
        SWAP: u1 = 0,
        /// [16:17] RX pin active level inversion
        RXINV: u1 = 0,
        /// [17:18] TX pin active level inversion
        TXINV: u1 = 0,
        /// [18:19] Binary data inversion
        TAINV: u1 = 0,
        /// [19:20] Most significant bit first
        MSBFIRST: u1 = 0,
        _unused20: u4 = 0,
        /// [24:28] Address of the USART node
        ADD0_3: u4 = 0,
        /// [28:32] Address of the USART node
        ADD4_7: u4 = 0,
    }),
    /// [+0x08] Control register 3
    CR3: r32(packed struct {
        /// [0:1] Error interrupt enable
        EIE: u1 = 0,
        _unused1: u2 = 0,
        /// [3:4] Half-duplex selection
        HDSEL: u1 = 0,
        _unused4: u2 = 0,
        /// [6:7] DMA enable receiver
        DMAR: u1 = 0,
        /// [7:8] DMA enable transmitter
        DMAT: u1 = 0,
        /// [8:9] RTS enable
        RTSE: u1 = 0,
        /// [9:10] CTS enable
        CTSE: u1 = 0,
        /// [10:11] CTS interrupt enable
        CTSIE: u1 = 0,
        _unused11: u1 = 0,
        /// [12:13] Overrun Disable
        OVRDIS: u1 = 0,
        /// [13:14] DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// [14:15] Driver enable mode
        DEM: u1 = 0,
        /// [15:16] Driver enable polarity selection
        DEP: u1 = 0,
        _unused16: u4 = 0,
        /// [20:22] Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// [22:23] Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x0C] Baud rate register
    BRR: r32(packed struct {
        /// [0:20] BRR
        BRR: u20 = 0,
        _unused20: u12 = 0,
    }),
    _unused16: [8]u8,
    /// [+0x18] Request register
    RQR: r32(packed struct {
        _unused0: u1 = 0,
        /// [1:2] Send break request
        SBKRQ: u1 = 0,
        /// [2:3] Mute mode request
        MMRQ: u1 = 0,
        /// [3:4] Receive data flush request
        RXFRQ: u1 = 0,
        _unused4: u28 = 0,
    }),
    /// [+0x1C] Interrupt & status register
    ISR: r32(packed struct {
        /// [0:1] PE
        PE: u1 = 0,
        /// [1:2] FE
        FE: u1 = 0,
        /// [2:3] NF
        NF: u1 = 0,
        /// [3:4] ORE
        ORE: u1 = 0,
        /// [4:5] IDLE
        IDLE: u1 = 0,
        /// [5:6] RXNE
        RXNE: u1 = 0,
        /// [6:7] TC
        TC: u1 = 0,
        /// [7:8] TXE
        TXE: u1 = 0,
        _unused8: u1 = 0,
        /// [9:10] CTSIF
        CTSIF: u1 = 0,
        /// [10:11] CTS
        CTS: u1 = 0,
        _unused11: u5 = 0,
        /// [16:17] BUSY
        BUSY: u1 = 0,
        /// [17:18] CMF
        CMF: u1 = 0,
        /// [18:19] SBKF
        SBKF: u1 = 0,
        /// [19:20] RWU
        RWU: u1 = 0,
        /// [20:21] WUF
        WUF: u1 = 0,
        /// [21:22] TEACK
        TEACK: u1 = 0,
        /// [22:23] REACK
        REACK: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x20] Interrupt flag clear register
    ICR: r32(packed struct {
        /// [0:1] Parity error clear flag
        PECF: u1 = 0,
        /// [1:2] Framing error clear flag
        FECF: u1 = 0,
        /// [2:3] Noise detected clear flag
        NCF: u1 = 0,
        /// [3:4] Overrun error clear flag
        ORECF: u1 = 0,
        /// [4:5] Idle line detected clear flag
        IDLECF: u1 = 0,
        _unused5: u1 = 0,
        /// [6:7] Transmission complete clear flag
        TCCF: u1 = 0,
        _unused7: u2 = 0,
        /// [9:10] CTS clear flag
        CTSCF: u1 = 0,
        _unused10: u7 = 0,
        /// [17:18] Character match clear flag
        CMCF: u1 = 0,
        _unused18: u2 = 0,
        /// [20:21] Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        _unused21: u11 = 0,
    }),
    /// [+0x24] Receive data register
    RDR: r32(packed struct {
        /// [0:9] Receive data value
        RDR: u9 = 0,
        _unused9: u23 = 0,
    }),
    /// [+0x28] Transmit data register
    TDR: r32(packed struct {
        /// [0:9] Transmit data value
        TDR: u9 = 0,
        _unused9: u23 = 0,
    }),
};

/// Memory protection unit
pub const MPU_Peripheral = packed struct {
    /// [+0x00] MPU type register
    TYPER: r32(packed struct {
        /// [0:1] Separate flag
        SEPARATE: u1 = 0,
        _unused1: u7 = 0,
        /// [8:16] Number of MPU data regions
        DREGION: u8 = 0,
        /// [16:24] Number of MPU instruction regions
        IREGION: u8 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x04] MPU control register
    CTRL: r32(packed struct {
        /// [0:1] Enables the MPU
        ENABLE: u1 = 0,
        /// [1:2] Enables the operation of MPU during hard fault
        HFNMIENA: u1 = 0,
        /// [2:3] Enable priviliged software access to default memory map
        PRIVDEFENA: u1 = 0,
        _unused3: u29 = 0,
    }),
    /// [+0x08] MPU region number register
    RNR: r32(packed struct {
        /// [0:8] MPU region
        REGION: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x0C] MPU region base address register
    RBAR: r32(packed struct {
        /// [0:4] MPU region field
        REGION: u4 = 0,
        /// [4:5] MPU region number valid
        VALID: u1 = 0,
        /// [5:32] Region base address field
        ADDR: u27 = 0,
    }),
    /// [+0x10] MPU region attribute and size register
    RASR: r32(packed struct {
        /// [0:1] Region enable bit.
        ENABLE: u1 = 0,
        /// [1:6] Size of the MPU protection region
        SIZE: u5 = 0,
        _unused6: u2 = 0,
        /// [8:16] Subregion disable bits
        SRD: u8 = 0,
        /// [16:17] memory attribute
        B: u1 = 0,
        /// [17:18] memory attribute
        C: u1 = 0,
        /// [18:19] Shareable memory attribute
        S: u1 = 0,
        /// [19:22] memory attribute
        TEX: u3 = 0,
        _unused22: u2 = 0,
        /// [24:27] Access permission
        AP: u3 = 0,
        _unused27: u1 = 0,
        /// [28:29] Instruction access disable bit
        XN: u1 = 0,
        _unused29: u3 = 0,
    }),
};

/// Nested Vectored Interrupt Controller
pub const NVIC_Peripheral = packed struct {
    /// [+0x00] Interrupt Set Enable Register
    ISER: u32,
    _unused4: [124]u8,
    /// [+0x80] Interrupt Clear Enable Register
    ICER: u32,
    _unused132: [124]u8,
    /// [+0x100] Interrupt Set-Pending Register
    ISPR: u32,
    _unused260: [124]u8,
    /// [+0x180] Interrupt Clear-Pending Register
    ICPR: u32,
    _unused388: [380]u8,
    /// [+0x300] Interrupt Priority Register 0
    IPR0: r32(packed struct {
        /// [0:8] priority for interrupt 0
        PRI_0: u8 = 0,
        /// [8:16] priority for interrupt 1
        PRI_1: u8 = 0,
        /// [16:24] priority for interrupt 2
        PRI_2: u8 = 0,
        /// [24:32] priority for interrupt 3
        PRI_3: u8 = 0,
    }),
    /// [+0x304] Interrupt Priority Register 1
    IPR1: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_4: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_5: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_6: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_7: u8 = 0,
    }),
    /// [+0x308] Interrupt Priority Register 2
    IPR2: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_8: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_9: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_10: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_11: u8 = 0,
    }),
    /// [+0x30C] Interrupt Priority Register 3
    IPR3: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_12: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_13: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_14: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_15: u8 = 0,
    }),
    /// [+0x310] Interrupt Priority Register 4
    IPR4: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_16: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_17: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_18: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_19: u8 = 0,
    }),
    /// [+0x314] Interrupt Priority Register 5
    IPR5: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_20: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_21: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_22: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_23: u8 = 0,
    }),
    /// [+0x318] Interrupt Priority Register 6
    IPR6: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_24: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_25: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_26: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_27: u8 = 0,
    }),
    /// [+0x31C] Interrupt Priority Register 7
    IPR7: r32(packed struct {
        /// [0:8] priority for interrupt n
        PRI_28: u8 = 0,
        /// [8:16] priority for interrupt n
        PRI_29: u8 = 0,
        /// [16:24] priority for interrupt n
        PRI_30: u8 = 0,
        /// [24:32] priority for interrupt n
        PRI_31: u8 = 0,
    }),
};

/// Power control
pub const PWR_Peripheral = packed struct {
    /// [+0x00] power control register
    CR: r32(packed struct {
        /// [0:1] Low-power deep sleep
        LPDS: u1 = 0,
        /// [1:2] Power down deepsleep
        PDDS: u1 = 0,
        /// [2:3] Clear wakeup flag
        CWUF: u1 = 0,
        /// [3:4] Clear standby flag
        CSBF: u1 = 0,
        /// [4:5] Power voltage detector enable
        PVDE: u1 = 0,
        /// [5:8] PVD level selection
        PLS: u3 = 0,
        /// [8:9] Disable backup domain write protection
        DBP: u1 = 0,
        /// [9:10] Ultra-low-power mode
        ULP: u1 = 0,
        /// [10:11] Fast wakeup
        FWU: u1 = 0,
        /// [11:13] Voltage scaling range selection
        VOS: u2 = 0,
        /// [13:14] Deep sleep mode with Flash memory kept off
        DS_EE_KOFF: u1 = 0,
        /// [14:15] Low power run mode
        LPRUN: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x04] power control/status register
    CSR: r32(packed struct {
        /// [0:1] Wakeup flag
        WUF: u1 = 0,
        /// [1:2] Standby flag
        SBF: u1 = 0,
        /// [2:3] PVD output
        PVDO: u1 = 0,
        /// [3:4] Backup regulator ready
        BRR: u1 = 0,
        /// [4:5] Voltage Scaling select flag
        VOSF: u1 = 0,
        /// [5:6] Regulator LP flag
        REGLPF: u1 = 0,
        _unused6: u2 = 0,
        /// [8:9] Enable WKUP pin
        EWUP: u1 = 0,
        /// [9:10] Backup regulator enable
        BRE: u1 = 0,
        _unused10: u22 = 0,
    }),
};

/// Reset and clock control
pub const RCC_Peripheral = packed struct {
    /// [+0x00] Clock control register
    CR: r32(packed struct {
        /// [0:1] 16 MHz high-speed internal clock enable
        HSI16ON: u1 = 0,
        /// [1:2] High-speed internal clock enable bit for some IP kernels
        HSI16KERON: u1 = 0,
        /// [2:3] Internal high-speed clock ready flag
        HSI16RDYF: u1 = 0,
        /// [3:4] HSI16DIVEN
        HSI16DIVEN: u1 = 0,
        /// [4:5] HSI16DIVF
        HSI16DIVF: u1 = 0,
        /// [5:6] 16 MHz high-speed internal clock output enable
        HSI16OUTEN: u1 = 0,
        _unused6: u2 = 0,
        /// [8:9] MSI clock enable bit
        MSION: u1 = 0,
        /// [9:10] MSI clock ready flag
        MSIRDY: u1 = 0,
        _unused10: u6 = 0,
        /// [16:17] HSE clock enable bit
        HSEON: u1 = 0,
        /// [17:18] HSE clock ready flag
        HSERDY: u1 = 0,
        /// [18:19] HSE clock bypass bit
        HSEBYP: u1 = 0,
        /// [19:20] Clock security system on HSE enable bit
        CSSLSEON: u1 = 0,
        /// [20:22] TC/LCD prescaler
        RTCPRE: u2 = 0,
        _unused22: u2 = 0,
        /// [24:25] PLL enable bit
        PLLON: u1 = 0,
        /// [25:26] PLL clock ready flag
        PLLRDY: u1 = 0,
        _unused26: u6 = 0,
    }),
    /// [+0x04] Internal clock sources calibration register
    ICSCR: r32(packed struct {
        /// [0:8] nternal high speed clock calibration
        HSI16CAL: u8 = 0,
        /// [8:13] High speed internal clock trimming
        HSI16TRIM: u5 = 0,
        /// [13:16] MSI clock ranges
        MSIRANGE: u3 = 0,
        /// [16:24] MSI clock calibration
        MSICAL: u8 = 0,
        /// [24:32] MSI clock trimming
        MSITRIM: u8 = 0,
    }),
    /// [+0x08] Clock recovery RC register
    CRRCR: r32(packed struct {
        /// [0:1] 48MHz HSI clock enable bit
        HSI48ON: u1 = 0,
        /// [1:2] 48MHz HSI clock ready flag
        HSI48RDY: u1 = 0,
        /// [2:3] 48 MHz HSI clock divided by 6 output enable
        HSI48DIV6EN: u1 = 0,
        _unused3: u5 = 0,
        /// [8:16] 48 MHz HSI clock calibration
        HSI48CAL: u8 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x0C] Clock configuration register
    CFGR: r32(packed struct {
        /// [0:2] System clock switch
        SW: u2 = 0,
        /// [2:4] System clock switch status
        SWS: u2 = 0,
        /// [4:8] AHB prescaler
        HPRE: u4 = 0,
        /// [8:11] APB low-speed prescaler (APB1)
        PPRE1: u3 = 0,
        /// [11:14] APB high-speed prescaler (APB2)
        PPRE2: u3 = 0,
        _unused14: u1 = 0,
        /// [15:16] Wake-up from stop clock selection
        STOPWUCK: u1 = 0,
        /// [16:17] PLL entry clock source
        PLLSRC: u1 = 0,
        _unused17: u1 = 0,
        /// [18:22] PLL multiplication factor
        PLLMUL: u4 = 0,
        /// [22:24] PLL output division
        PLLDIV: u2 = 0,
        /// [24:28] Microcontroller clock output selection
        MCOSEL: u4 = 0,
        /// [28:31] Microcontroller clock output prescaler
        MCOPRE: u3 = 0,
        _unused31: u1 = 0,
    }),
    /// [+0x10] Clock interrupt enable register
    CIER: r32(packed struct {
        /// [0:1] LSI ready interrupt flag
        LSIRDYIE: u1 = 0,
        /// [1:2] LSE ready interrupt flag
        LSERDYIE: u1 = 0,
        /// [2:3] HSI16 ready interrupt flag
        HSI16RDYIE: u1 = 0,
        /// [3:4] HSE ready interrupt flag
        HSERDYIE: u1 = 0,
        /// [4:5] PLL ready interrupt flag
        PLLRDYIE: u1 = 0,
        /// [5:6] MSI ready interrupt flag
        MSIRDYIE: u1 = 0,
        /// [6:7] HSI48 ready interrupt flag
        HSI48RDYIE: u1 = 0,
        /// [7:8] LSE CSS interrupt flag
        CSSLSE: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x14] Clock interrupt flag register
    CIFR: r32(packed struct {
        /// [0:1] LSI ready interrupt flag
        LSIRDYF: u1 = 0,
        /// [1:2] LSE ready interrupt flag
        LSERDYF: u1 = 0,
        /// [2:3] HSI16 ready interrupt flag
        HSI16RDYF: u1 = 0,
        /// [3:4] HSE ready interrupt flag
        HSERDYF: u1 = 0,
        /// [4:5] PLL ready interrupt flag
        PLLRDYF: u1 = 0,
        /// [5:6] MSI ready interrupt flag
        MSIRDYF: u1 = 0,
        /// [6:7] HSI48 ready interrupt flag
        HSI48RDYF: u1 = 0,
        /// [7:8] LSE Clock Security System Interrupt flag
        CSSLSEF: u1 = 0,
        /// [8:9] Clock Security System Interrupt flag
        CSSHSEF: u1 = 0,
        _unused9: u23 = 0,
    }),
    /// [+0x18] Clock interrupt clear register
    CICR: r32(packed struct {
        /// [0:1] LSI ready Interrupt clear
        LSIRDYC: u1 = 0,
        /// [1:2] LSE ready Interrupt clear
        LSERDYC: u1 = 0,
        /// [2:3] HSI16 ready Interrupt clear
        HSI16RDYC: u1 = 0,
        /// [3:4] HSE ready Interrupt clear
        HSERDYC: u1 = 0,
        /// [4:5] PLL ready Interrupt clear
        PLLRDYC: u1 = 0,
        /// [5:6] MSI ready Interrupt clear
        MSIRDYC: u1 = 0,
        /// [6:7] HSI48 ready Interrupt clear
        HSI48RDYC: u1 = 0,
        /// [7:8] LSE Clock Security System Interrupt clear
        CSSLSEC: u1 = 0,
        /// [8:9] Clock Security System Interrupt clear
        CSSHSEC: u1 = 0,
        _unused9: u23 = 0,
    }),
    /// [+0x1C] GPIO reset register
    IOPRSTR: r32(packed struct {
        /// [0:1] I/O port A reset
        IOPARST: u1 = 0,
        /// [1:2] I/O port B reset
        IOPBRST: u1 = 0,
        /// [2:3] I/O port A reset
        IOPCRST: u1 = 0,
        /// [3:4] I/O port D reset
        IOPDRST: u1 = 0,
        /// [4:5] I/O port E reset
        IOPERST: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] I/O port H reset
        IOPHRST: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x20] AHB peripheral reset register
    AHBRSTR: r32(packed struct {
        /// [0:1] DMA reset
        DMARST: u1 = 0,
        _unused1: u7 = 0,
        /// [8:9] Memory interface reset
        MIFRST: u1 = 0,
        _unused9: u3 = 0,
        /// [12:13] Test integration module reset
        CRCRST: u1 = 0,
        _unused13: u3 = 0,
        /// [16:17] Touch Sensing reset
        TOUCHRST: u1 = 0,
        _unused17: u3 = 0,
        /// [20:21] Random Number Generator module reset
        RNGRST: u1 = 0,
        _unused21: u3 = 0,
        /// [24:25] Crypto module reset
        CRYPRST: u1 = 0,
        _unused25: u7 = 0,
    }),
    /// [+0x24] APB2 peripheral reset register
    APB2RSTR: r32(packed struct {
        /// [0:1] System configuration controller reset
        SYSCFGRST: u1 = 0,
        _unused1: u1 = 0,
        /// [2:3] TIM21 timer reset
        TIM21RST: u1 = 0,
        _unused3: u2 = 0,
        /// [5:6] TIM22 timer reset
        TM12RST: u1 = 0,
        _unused6: u3 = 0,
        /// [9:10] ADC interface reset
        ADCRST: u1 = 0,
        _unused10: u2 = 0,
        /// [12:13] SPI 1 reset
        SPI1RST: u1 = 0,
        _unused13: u1 = 0,
        /// [14:15] USART1 reset
        USART1RST: u1 = 0,
        _unused15: u7 = 0,
        /// [22:23] DBG reset
        DBGRST: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x28] APB1 peripheral reset register
    APB1RSTR: r32(packed struct {
        /// [0:1] Timer2 reset
        TIM2RST: u1 = 0,
        /// [1:2] Timer3 reset
        TIM3RST: u1 = 0,
        _unused2: u2 = 0,
        /// [4:5] Timer 6 reset
        TIM6RST: u1 = 0,
        /// [5:6] Timer 7 reset
        TIM7RST: u1 = 0,
        _unused6: u5 = 0,
        /// [11:12] Window watchdog reset
        WWDRST: u1 = 0,
        _unused12: u2 = 0,
        /// [14:15] SPI2 reset
        SPI2RST: u1 = 0,
        _unused15: u2 = 0,
        /// [17:18] UART2 reset
        LPUART12RST: u1 = 0,
        /// [18:19] LPUART1 reset
        LPUART1RST: u1 = 0,
        /// [19:20] USART4 reset
        USART4RST: u1 = 0,
        /// [20:21] USART5 reset
        USART5RST: u1 = 0,
        /// [21:22] I2C1 reset
        I2C1RST: u1 = 0,
        /// [22:23] I2C2 reset
        I2C2RST: u1 = 0,
        /// [23:24] USB reset
        USBRST: u1 = 0,
        _unused24: u3 = 0,
        /// [27:28] Clock recovery system reset
        CRSRST: u1 = 0,
        /// [28:29] Power interface reset
        PWRRST: u1 = 0,
        /// [29:30] DAC interface reset
        DACRST: u1 = 0,
        /// [30:31] I2C3 reset
        I2C3RST: u1 = 0,
        /// [31:32] Low power timer reset
        LPTIM1RST: u1 = 0,
    }),
    /// [+0x2C] GPIO clock enable register
    IOPENR: r32(packed struct {
        /// [0:1] IO port A clock enable bit
        IOPAEN: u1 = 0,
        /// [1:2] IO port B clock enable bit
        IOPBEN: u1 = 0,
        /// [2:3] IO port A clock enable bit
        IOPCEN: u1 = 0,
        /// [3:4] I/O port D clock enable bit
        IOPDEN: u1 = 0,
        /// [4:5] I/O port E clock enable bit
        IOPEEN: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] I/O port H clock enable bit
        IOPHEN: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x30] AHB peripheral clock enable register
    AHBENR: r32(packed struct {
        /// [0:1] DMA clock enable bit
        DMAEN: u1 = 0,
        _unused1: u7 = 0,
        /// [8:9] NVM interface clock enable bit
        MIFEN: u1 = 0,
        _unused9: u3 = 0,
        /// [12:13] CRC clock enable bit
        CRCEN: u1 = 0,
        _unused13: u3 = 0,
        /// [16:17] Touch Sensing clock enable bit
        TOUCHEN: u1 = 0,
        _unused17: u3 = 0,
        /// [20:21] Random Number Generator clock enable bit
        RNGEN: u1 = 0,
        _unused21: u3 = 0,
        /// [24:25] Crypto clock enable bit
        CRYPEN: u1 = 0,
        _unused25: u7 = 0,
    }),
    /// [+0x34] APB2 peripheral clock enable register
    APB2ENR: r32(packed struct {
        /// [0:1] System configuration controller clock enable bit
        SYSCFGEN: u1 = 0,
        _unused1: u1 = 0,
        /// [2:3] TIM21 timer clock enable bit
        TIM21EN: u1 = 0,
        _unused3: u2 = 0,
        /// [5:6] TIM22 timer clock enable bit
        TIM22EN: u1 = 0,
        _unused6: u1 = 0,
        /// [7:8] MiFaRe Firewall clock enable bit
        MIFIEN: u1 = 0,
        _unused8: u1 = 0,
        /// [9:10] ADC clock enable bit
        ADCEN: u1 = 0,
        _unused10: u2 = 0,
        /// [12:13] SPI1 clock enable bit
        SPI1EN: u1 = 0,
        _unused13: u1 = 0,
        /// [14:15] USART1 clock enable bit
        USART1EN: u1 = 0,
        _unused15: u7 = 0,
        /// [22:23] DBG clock enable bit
        DBGEN: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x38] APB1 peripheral clock enable register
    APB1ENR: r32(packed struct {
        /// [0:1] Timer2 clock enable bit
        TIM2EN: u1 = 0,
        /// [1:2] Timer3 clock enable bit
        TIM3EN: u1 = 0,
        _unused2: u2 = 0,
        /// [4:5] Timer 6 clock enable bit
        TIM6EN: u1 = 0,
        /// [5:6] Timer 7 clock enable bit
        TIM7EN: u1 = 0,
        _unused6: u5 = 0,
        /// [11:12] Window watchdog clock enable bit
        WWDGEN: u1 = 0,
        _unused12: u2 = 0,
        /// [14:15] SPI2 clock enable bit
        SPI2EN: u1 = 0,
        _unused15: u2 = 0,
        /// [17:18] UART2 clock enable bit
        USART2EN: u1 = 0,
        /// [18:19] LPUART1 clock enable bit
        LPUART1EN: u1 = 0,
        /// [19:20] USART4 clock enable bit
        USART4EN: u1 = 0,
        /// [20:21] USART5 clock enable bit
        USART5EN: u1 = 0,
        /// [21:22] I2C1 clock enable bit
        I2C1EN: u1 = 0,
        /// [22:23] I2C2 clock enable bit
        I2C2EN: u1 = 0,
        /// [23:24] USB clock enable bit
        USBEN: u1 = 0,
        _unused24: u3 = 0,
        /// [27:28] Clock recovery system clock enable bit
        CRSEN: u1 = 0,
        /// [28:29] Power interface clock enable bit
        PWREN: u1 = 0,
        /// [29:30] DAC interface clock enable bit
        DACEN: u1 = 0,
        /// [30:31] I2C3 clock enable bit
        I2C3EN: u1 = 0,
        /// [31:32] Low power timer clock enable bit
        LPTIM1EN: u1 = 0,
    }),
    /// [+0x3C] GPIO clock enable in sleep mode register
    IOPSMEN: r32(packed struct {
        /// [0:1] IOPASMEN
        IOPASMEN: u1 = 0,
        /// [1:2] IOPBSMEN
        IOPBSMEN: u1 = 0,
        /// [2:3] IOPCSMEN
        IOPCSMEN: u1 = 0,
        /// [3:4] IOPDSMEN
        IOPDSMEN: u1 = 0,
        /// [4:5] Port E clock enable during Sleep mode bit
        IOPESMEN: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] IOPHSMEN
        IOPHSMEN: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x40] AHB peripheral clock enable in sleep mode register
    AHBSMENR: r32(packed struct {
        /// [0:1] DMA clock enable during sleep mode bit
        DMASMEN: u1 = 0,
        _unused1: u7 = 0,
        /// [8:9] NVM interface clock enable during sleep mode bit
        MIFSMEN: u1 = 0,
        /// [9:10] SRAM interface clock enable during sleep mode bit
        SRAMSMEN: u1 = 0,
        _unused10: u2 = 0,
        /// [12:13] CRC clock enable during sleep mode bit
        CRCSMEN: u1 = 0,
        _unused13: u3 = 0,
        /// [16:17] Touch Sensing clock enable during sleep mode bit
        TOUCHSMEN: u1 = 0,
        _unused17: u3 = 0,
        /// [20:21] Random Number Generator clock enable during sleep mode bit
        RNGSMEN: u1 = 0,
        _unused21: u3 = 0,
        /// [24:25] Crypto clock enable during sleep mode bit
        CRYPSMEN: u1 = 0,
        _unused25: u7 = 0,
    }),
    /// [+0x44] APB2 peripheral clock enable in sleep mode register
    APB2SMENR: r32(packed struct {
        /// [0:1] System configuration controller clock enable during sleep mode bit
        SYSCFGSMEN: u1 = 0,
        _unused1: u1 = 0,
        /// [2:3] TIM21 timer clock enable during sleep mode bit
        TIM21SMEN: u1 = 0,
        _unused3: u2 = 0,
        /// [5:6] TIM22 timer clock enable during sleep mode bit
        TIM22SMEN: u1 = 0,
        _unused6: u3 = 0,
        /// [9:10] ADC clock enable during sleep mode bit
        ADCSMEN: u1 = 0,
        _unused10: u2 = 0,
        /// [12:13] SPI1 clock enable during sleep mode bit
        SPI1SMEN: u1 = 0,
        _unused13: u1 = 0,
        /// [14:15] USART1 clock enable during sleep mode bit
        USART1SMEN: u1 = 0,
        _unused15: u7 = 0,
        /// [22:23] DBG clock enable during sleep mode bit
        DBGSMEN: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x48] APB1 peripheral clock enable in sleep mode register
    APB1SMENR: r32(packed struct {
        /// [0:1] Timer2 clock enable during sleep mode bit
        TIM2SMEN: u1 = 0,
        /// [1:2] Timer3 clock enable during Sleep mode bit
        TIM3SMEN: u1 = 0,
        _unused2: u2 = 0,
        /// [4:5] Timer 6 clock enable during sleep mode bit
        TIM6SMEN: u1 = 0,
        /// [5:6] Timer 7 clock enable during Sleep mode bit
        TIM7SMEN: u1 = 0,
        _unused6: u5 = 0,
        /// [11:12] Window watchdog clock enable during sleep mode bit
        WWDGSMEN: u1 = 0,
        _unused12: u2 = 0,
        /// [14:15] SPI2 clock enable during sleep mode bit
        SPI2SMEN: u1 = 0,
        _unused15: u2 = 0,
        /// [17:18] UART2 clock enable during sleep mode bit
        USART2SMEN: u1 = 0,
        /// [18:19] LPUART1 clock enable during sleep mode bit
        LPUART1SMEN: u1 = 0,
        /// [19:20] USART4 clock enable during Sleep mode bit
        USART4SMEN: u1 = 0,
        /// [20:21] USART5 clock enable during Sleep mode bit
        USART5SMEN: u1 = 0,
        /// [21:22] I2C1 clock enable during sleep mode bit
        I2C1SMEN: u1 = 0,
        /// [22:23] I2C2 clock enable during sleep mode bit
        I2C2SMEN: u1 = 0,
        /// [23:24] USB clock enable during sleep mode bit
        USBSMEN: u1 = 0,
        _unused24: u3 = 0,
        /// [27:28] Clock recovery system clock enable during sleep mode bit
        CRSSMEN: u1 = 0,
        /// [28:29] Power interface clock enable during sleep mode bit
        PWRSMEN: u1 = 0,
        /// [29:30] DAC interface clock enable during sleep mode bit
        DACSMEN: u1 = 0,
        /// [30:31] 2C3 clock enable during Sleep mode bit
        I2C3SMEN: u1 = 0,
        /// [31:32] Low power timer clock enable during sleep mode bit
        LPTIM1SMEN: u1 = 0,
    }),
    /// [+0x4C] Clock configuration register
    CCIPR: r32(packed struct {
        /// [0:1] USART1SEL0
        USART1SEL0: u1 = 0,
        /// [1:2] USART1 clock source selection bits
        USART1SEL1: u1 = 0,
        /// [2:3] USART2SEL0
        USART2SEL0: u1 = 0,
        /// [3:4] USART2 clock source selection bits
        USART2SEL1: u1 = 0,
        _unused4: u6 = 0,
        /// [10:11] LPUART1SEL0
        LPUART1SEL0: u1 = 0,
        /// [11:12] LPUART1 clock source selection bits
        LPUART1SEL1: u1 = 0,
        /// [12:13] I2C1SEL0
        I2C1SEL0: u1 = 0,
        /// [13:14] I2C1 clock source selection bits
        I2C1SEL1: u1 = 0,
        _unused14: u2 = 0,
        /// [16:18] I2C3 clock source selection bits
        I2C3SEL: u2 = 0,
        /// [18:19] LPTIM1SEL0
        LPTIM1SEL0: u1 = 0,
        /// [19:20] Low Power Timer clock source selection bits
        LPTIM1SEL1: u1 = 0,
        _unused20: u6 = 0,
        /// [26:27] 48 MHz HSI48 clock source selection bit
        HSI48MSEL: u1 = 0,
        _unused27: u5 = 0,
    }),
    /// [+0x50] Control and status register
    CSR: r32(packed struct {
        /// [0:1] Internal low-speed oscillator enable
        LSION: u1 = 0,
        /// [1:2] Internal low-speed oscillator ready bit
        LSIRDY: u1 = 0,
        _unused2: u6 = 0,
        /// [8:9] External low-speed oscillator enable bit
        LSEON: u1 = 0,
        /// [9:10] External low-speed oscillator ready bit
        LSERDY: u1 = 0,
        /// [10:11] External low-speed oscillator bypass bit
        LSEBYP: u1 = 0,
        /// [11:13] LSEDRV
        LSEDRV: u2 = 0,
        /// [13:14] CSSLSEON
        CSSLSEON: u1 = 0,
        /// [14:15] CSS on LSE failure detection flag
        CSSLSED: u1 = 0,
        _unused15: u1 = 0,
        /// [16:18] RTC and LCD clock source selection bits
        RTCSEL: u2 = 0,
        /// [18:19] RTC clock enable bit
        RTCEN: u1 = 0,
        /// [19:20] RTC software reset bit
        RTCRST: u1 = 0,
        _unused20: u4 = 0,
        /// [24:25] Remove reset flag
        RMVF: u1 = 0,
        /// [25:26] OBLRSTF
        OBLRSTF: u1 = 0,
        /// [26:27] PIN reset flag
        PINRSTF: u1 = 0,
        /// [27:28] POR/PDR reset flag
        PORRSTF: u1 = 0,
        /// [28:29] Software reset flag
        SFTRSTF: u1 = 0,
        /// [29:30] Independent watchdog reset flag
        IWDGRSTF: u1 = 0,
        /// [30:31] Window watchdog reset flag
        WWDGRSTF: u1 = 0,
        /// [31:32] Low-power reset flag
        LPWRSTF: u1 = 0,
    }),
};

/// Random number generator
pub const RNG_Peripheral = packed struct {
    /// [+0x00] control register
    CR: r32(packed struct {
        _unused0: u2 = 0,
        /// [2:3] Random number generator enable
        RNGEN: u1 = 0,
        /// [3:4] Interrupt enable
        IE: u1 = 0,
        _unused4: u28 = 0,
    }),
    /// [+0x04] status register
    SR: r32(packed struct {
        /// [0:1] Data ready
        DRDY: u1 = 0,
        /// [1:2] Clock error current status
        CECS: u1 = 0,
        /// [2:3] Seed error current status
        SECS: u1 = 0,
        _unused3: u2 = 0,
        /// [5:6] Clock error interrupt status
        CEIS: u1 = 0,
        /// [6:7] Seed error interrupt status
        SEIS: u1 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x08] data register
    DR: u32,
};

/// Real-time clock
pub const RTC_Peripheral = packed struct {
    /// [+0x00] RTC time register
    TR: r32(packed struct {
        /// [0:4] Second units in BCD format
        SU: u4 = 0,
        /// [4:7] Second tens in BCD format
        ST: u3 = 0,
        _unused7: u1 = 0,
        /// [8:12] Minute units in BCD format
        MNU: u4 = 0,
        /// [12:15] Minute tens in BCD format
        MNT: u3 = 0,
        _unused15: u1 = 0,
        /// [16:20] Hour units in BCD format
        HU: u4 = 0,
        /// [20:22] Hour tens in BCD format
        HT: u2 = 0,
        /// [22:23] AM/PM notation
        PM: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x04] RTC date register
    DR: r32(packed struct {
        /// [0:4] Date units in BCD format
        DU: u4 = 0,
        /// [4:6] Date tens in BCD format
        DT: u2 = 0,
        _unused6: u2 = 0,
        /// [8:12] Month units in BCD format
        MU: u4 = 0,
        /// [12:13] Month tens in BCD format
        MT: u1 = 0,
        /// [13:16] Week day units
        WDU: u3 = 0,
        /// [16:20] Year units in BCD format
        YU: u4 = 0,
        /// [20:24] Year tens in BCD format
        YT: u4 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x08] RTC control register
    CR: r32(packed struct {
        /// [0:3] Wakeup clock selection
        WUCKSEL: u3 = 0,
        /// [3:4] Time-stamp event active edge
        TSEDGE: u1 = 0,
        /// [4:5] RTC_REFIN reference clock detection enable (50 or 60 Hz)
        REFCKON: u1 = 0,
        /// [5:6] Bypass the shadow registers
        BYPSHAD: u1 = 0,
        /// [6:7] Hour format
        FMT: u1 = 0,
        _unused7: u1 = 0,
        /// [8:9] Alarm A enable
        ALRAE: u1 = 0,
        /// [9:10] Alarm B enable
        ALRBE: u1 = 0,
        /// [10:11] Wakeup timer enable
        WUTE: u1 = 0,
        /// [11:12] timestamp enable
        TSE: u1 = 0,
        /// [12:13] Alarm A interrupt enable
        ALRAIE: u1 = 0,
        /// [13:14] Alarm B interrupt enable
        ALRBIE: u1 = 0,
        /// [14:15] Wakeup timer interrupt enable
        WUTIE: u1 = 0,
        /// [15:16] Time-stamp interrupt enable
        TSIE: u1 = 0,
        /// [16:17] Add 1 hour (summer time change)
        ADD1H: u1 = 0,
        /// [17:18] Subtract 1 hour (winter time change)
        SUB1H: u1 = 0,
        /// [18:19] Backup
        BKP: u1 = 0,
        /// [19:20] Calibration output selection
        COSEL: u1 = 0,
        /// [20:21] Output polarity
        POL: u1 = 0,
        /// [21:23] Output selection
        OSEL: u2 = 0,
        /// [23:24] Calibration output enable
        COE: u1 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x0C] RTC initialization and status register
    ISR: r32(packed struct {
        /// [0:1] Alarm A write flag
        ALRAWF: u1 = 0,
        /// [1:2] Alarm B write flag
        ALRBWF: u1 = 0,
        /// [2:3] Wakeup timer write flag
        WUTWF: u1 = 0,
        /// [3:4] Shift operation pending
        SHPF: u1 = 0,
        /// [4:5] Initialization status flag
        INITS: u1 = 0,
        /// [5:6] Registers synchronization flag
        RSF: u1 = 0,
        /// [6:7] Initialization flag
        INITF: u1 = 0,
        /// [7:8] Initialization mode
        INIT: u1 = 0,
        /// [8:9] Alarm A flag
        ALRAF: u1 = 0,
        /// [9:10] Alarm B flag
        ALRBF: u1 = 0,
        /// [10:11] Wakeup timer flag
        WUTF: u1 = 0,
        /// [11:12] Time-stamp flag
        TSF: u1 = 0,
        /// [12:13] Time-stamp overflow flag
        TSOVF: u1 = 0,
        /// [13:14] RTC_TAMP1 detection flag
        TAMP1F: u1 = 0,
        /// [14:15] RTC_TAMP2 detection flag
        TAMP2F: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x10] RTC prescaler register
    PRER: r32(packed struct {
        /// [0:16] Synchronous prescaler factor
        PREDIV_S: u16 = 0,
        /// [16:23] Asynchronous prescaler factor
        PREDIV_A: u7 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x14] RTC wakeup timer register
    WUTR: r32(packed struct {
        /// [0:16] Wakeup auto-reload value bits
        WUT: u16 = 0,
        _unused16: u16 = 0,
    }),
    _unused24: u32,
    /// [+0x1C] RTC alarm A register
    ALRMAR: r32(packed struct {
        /// [0:4] Second units in BCD format.
        SU: u4 = 0,
        /// [4:7] Second tens in BCD format.
        ST: u3 = 0,
        /// [7:8] Alarm A seconds mask
        MSK1: u1 = 0,
        /// [8:12] Minute units in BCD format.
        MNU: u4 = 0,
        /// [12:15] Minute tens in BCD format.
        MNT: u3 = 0,
        /// [15:16] Alarm A minutes mask
        MSK2: u1 = 0,
        /// [16:20] Hour units in BCD format.
        HU: u4 = 0,
        /// [20:22] Hour tens in BCD format.
        HT: u2 = 0,
        /// [22:23] AM/PM notation
        PM: u1 = 0,
        /// [23:24] Alarm A hours mask
        MSK3: u1 = 0,
        /// [24:28] Date units or day in BCD format.
        DU: u4 = 0,
        /// [28:30] Date tens in BCD format.
        DT: u2 = 0,
        /// [30:31] Week day selection
        WDSEL: u1 = 0,
        /// [31:32] Alarm A date mask
        MSK4: u1 = 0,
    }),
    /// [+0x20] RTC alarm B register
    ALRMBR: r32(packed struct {
        /// [0:4] Second units in BCD format
        SU: u4 = 0,
        /// [4:7] Second tens in BCD format
        ST: u3 = 0,
        /// [7:8] Alarm B seconds mask
        MSK1: u1 = 0,
        /// [8:12] Minute units in BCD format
        MNU: u4 = 0,
        /// [12:15] Minute tens in BCD format
        MNT: u3 = 0,
        /// [15:16] Alarm B minutes mask
        MSK2: u1 = 0,
        /// [16:20] Hour units in BCD format
        HU: u4 = 0,
        /// [20:22] Hour tens in BCD format
        HT: u2 = 0,
        /// [22:23] AM/PM notation
        PM: u1 = 0,
        /// [23:24] Alarm B hours mask
        MSK3: u1 = 0,
        /// [24:28] Date units or day in BCD format
        DU: u4 = 0,
        /// [28:30] Date tens in BCD format
        DT: u2 = 0,
        /// [30:31] Week day selection
        WDSEL: u1 = 0,
        /// [31:32] Alarm B date mask
        MSK4: u1 = 0,
    }),
    /// [+0x24] write protection register
    WPR: r32(packed struct {
        /// [0:8] Write protection key
        KEY: u8 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x28] RTC sub second register
    SSR: r32(packed struct {
        /// [0:16] Sub second value
        SS: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x2C] RTC shift control register
    SHIFTR: r32(packed struct {
        /// [0:15] Subtract a fraction of a second
        SUBFS: u15 = 0,
        _unused15: u16 = 0,
        /// [31:32] Add one second
        ADD1S: u1 = 0,
    }),
    /// [+0x30] RTC timestamp time register
    TSTR: r32(packed struct {
        /// [0:4] Second units in BCD format.
        SU: u4 = 0,
        /// [4:7] Second tens in BCD format.
        ST: u3 = 0,
        _unused7: u1 = 0,
        /// [8:12] Minute units in BCD format.
        MNU: u4 = 0,
        /// [12:15] Minute tens in BCD format.
        MNT: u3 = 0,
        _unused15: u1 = 0,
        /// [16:20] Hour units in BCD format.
        HU: u4 = 0,
        /// [20:22] Hour tens in BCD format.
        HT: u2 = 0,
        /// [22:23] AM/PM notation
        PM: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x34] RTC timestamp date register
    TSDR: r32(packed struct {
        /// [0:4] Date units in BCD format
        DU: u4 = 0,
        /// [4:6] Date tens in BCD format
        DT: u2 = 0,
        _unused6: u2 = 0,
        /// [8:12] Month units in BCD format
        MU: u4 = 0,
        /// [12:13] Month tens in BCD format
        MT: u1 = 0,
        /// [13:16] Week day units
        WDU: u3 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x38] RTC time-stamp sub second register
    TSSSR: r32(packed struct {
        /// [0:16] Sub second value
        SS: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x3C] RTC calibration register
    CALR: r32(packed struct {
        /// [0:9] Calibration minus
        CALM: u9 = 0,
        _unused9: u4 = 0,
        /// [13:14] Use a 16-second calibration cycle period
        CALW16: u1 = 0,
        /// [14:15] Use a 8-second calibration cycle period
        CALW8: u1 = 0,
        /// [15:16] Increase frequency of RTC by 488.5 ppm
        CALP: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x40] RTC tamper configuration register
    TAMPCR: r32(packed struct {
        /// [0:1] RTC_TAMP1 input detection enable
        TAMP1E: u1 = 0,
        /// [1:2] Active level for RTC_TAMP1 input
        TAMP1TRG: u1 = 0,
        /// [2:3] Tamper interrupt enable
        TAMPIE: u1 = 0,
        /// [3:4] RTC_TAMP2 input detection enable
        TAMP2E: u1 = 0,
        /// [4:5] Active level for RTC_TAMP2 input
        TAMP2_TRG: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] Activate timestamp on tamper detection event
        TAMPTS: u1 = 0,
        /// [8:11] Tamper sampling frequency
        TAMPFREQ: u3 = 0,
        /// [11:13] RTC_TAMPx filter count
        TAMPFLT: u2 = 0,
        /// [13:15] RTC_TAMPx precharge duration
        TAMPPRCH: u2 = 0,
        /// [15:16] RTC_TAMPx pull-up disable
        TAMPPUDIS: u1 = 0,
        /// [16:17] Tamper 1 interrupt enable
        TAMP1IE: u1 = 0,
        /// [17:18] Tamper 1 no erase
        TAMP1NOERASE: u1 = 0,
        /// [18:19] Tamper 1 mask flag
        TAMP1MF: u1 = 0,
        /// [19:20] Tamper 2 interrupt enable
        TAMP2IE: u1 = 0,
        /// [20:21] Tamper 2 no erase
        TAMP2NOERASE: u1 = 0,
        /// [21:22] Tamper 2 mask flag
        TAMP2MF: u1 = 0,
        _unused22: u10 = 0,
    }),
    /// [+0x44] RTC alarm A sub second register
    ALRMASSR: r32(packed struct {
        /// [0:15] Sub seconds value
        SS: u15 = 0,
        _unused15: u9 = 0,
        /// [24:28] Mask the most-significant bits starting at this bit
        MASKSS: u4 = 0,
        _unused28: u4 = 0,
    }),
    /// [+0x48] RTC alarm B sub second register
    ALRMBSSR: r32(packed struct {
        /// [0:15] Sub seconds value
        SS: u15 = 0,
        _unused15: u9 = 0,
        /// [24:28] Mask the most-significant bits starting at this bit
        MASKSS: u4 = 0,
        _unused28: u4 = 0,
    }),
    /// [+0x4C] option register
    OR: r32(packed struct {
        /// [0:1] RTC_ALARM on PC13 output type
        RTC_ALARM_TYPE: u1 = 0,
        /// [1:2] RTC_ALARM on PC13 output type
        RTC_OUT_RMP: u1 = 0,
        _unused2: u30 = 0,
    }),
    /// [+0x50] RTC backup registers
    BKP0R: u32,
    /// [+0x54] RTC backup registers
    BKP1R: u32,
    /// [+0x58] RTC backup registers
    BKP2R: u32,
    /// [+0x5C] RTC backup registers
    BKP3R: u32,
    /// [+0x60] RTC backup registers
    BKP4R: u32,
};

/// System control block
pub const SCB_Peripheral = packed struct {
    /// [+0x00] CPUID base register
    CPUID: r32(packed struct {
        /// [0:4] Revision number
        Revision: u4 = 0,
        /// [4:16] Part number of the processor
        PartNo: u12 = 0,
        /// [16:20] Reads as 0xF
        Architecture: u4 = 0,
        /// [20:24] Variant number
        Variant: u4 = 0,
        /// [24:32] Implementer code
        Implementer: u8 = 0,
    }),
    /// [+0x04] Interrupt control and state register
    ICSR: r32(packed struct {
        /// [0:9] Active vector
        VECTACTIVE: u9 = 0,
        _unused9: u2 = 0,
        /// [11:12] Return to base level
        RETTOBASE: u1 = 0,
        /// [12:19] Pending vector
        VECTPENDING: u7 = 0,
        _unused19: u3 = 0,
        /// [22:23] Interrupt pending flag
        ISRPENDING: u1 = 0,
        _unused23: u2 = 0,
        /// [25:26] SysTick exception clear-pending bit
        PENDSTCLR: u1 = 0,
        /// [26:27] SysTick exception set-pending bit
        PENDSTSET: u1 = 0,
        /// [27:28] PendSV clear-pending bit
        PENDSVCLR: u1 = 0,
        /// [28:29] PendSV set-pending bit
        PENDSVSET: u1 = 0,
        _unused29: u2 = 0,
        /// [31:32] NMI set-pending bit.
        NMIPENDSET: u1 = 0,
    }),
    /// [+0x08] Vector table offset register
    VTOR: r32(packed struct {
        _unused0: u7 = 0,
        /// [7:32] Vector table base offset field
        TBLOFF: u25 = 0,
    }),
    /// [+0x0C] Application interrupt and reset control register
    AIRCR: r32(packed struct {
        _unused0: u1 = 0,
        /// [1:2] VECTCLRACTIVE
        VECTCLRACTIVE: u1 = 0,
        /// [2:3] SYSRESETREQ
        SYSRESETREQ: u1 = 0,
        _unused3: u12 = 0,
        /// [15:16] ENDIANESS
        ENDIANESS: u1 = 0,
        /// [16:32] Register key
        VECTKEYSTAT: u16 = 0,
    }),
    /// [+0x10] System control register
    SCR: r32(packed struct {
        _unused0: u1 = 0,
        /// [1:2] SLEEPONEXIT
        SLEEPONEXIT: u1 = 0,
        /// [2:3] SLEEPDEEP
        SLEEPDEEP: u1 = 0,
        _unused3: u1 = 0,
        /// [4:5] Send Event on Pending bit
        SEVEONPEND: u1 = 0,
        _unused5: u27 = 0,
    }),
    /// [+0x14] Configuration and control register
    CCR: r32(packed struct {
        /// [0:1] Configures how the processor enters Thread mode
        NONBASETHRDENA: u1 = 0,
        /// [1:2] USERSETMPEND
        USERSETMPEND: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] UNALIGN_ TRP
        UNALIGN__TRP: u1 = 0,
        /// [4:5] DIV_0_TRP
        DIV_0_TRP: u1 = 0,
        _unused5: u3 = 0,
        /// [8:9] BFHFNMIGN
        BFHFNMIGN: u1 = 0,
        /// [9:10] STKALIGN
        STKALIGN: u1 = 0,
        _unused10: u22 = 0,
    }),
    _unused24: u32,
    /// [+0x1C] System handler priority registers
    SHPR2: r32(packed struct {
        _unused0: u24 = 0,
        /// [24:32] Priority of system handler 11
        PRI_11: u8 = 0,
    }),
    /// [+0x20] System handler priority registers
    SHPR3: r32(packed struct {
        _unused0: u16 = 0,
        /// [16:24] Priority of system handler 14
        PRI_14: u8 = 0,
        /// [24:32] Priority of system handler 15
        PRI_15: u8 = 0,
    }),
};

/// Serial peripheral interface
pub const SPI_Peripheral = packed struct {
    /// [+0x00] control register 1
    CR1: r32(packed struct {
        /// [0:1] Clock phase
        CPHA: u1 = 0,
        /// [1:2] Clock polarity
        CPOL: u1 = 0,
        /// [2:3] Master selection
        MSTR: u1 = 0,
        /// [3:6] Baud rate control
        BR: u3 = 0,
        /// [6:7] SPI enable
        SPE: u1 = 0,
        /// [7:8] Frame format
        LSBFIRST: u1 = 0,
        /// [8:9] Internal slave select
        SSI: u1 = 0,
        /// [9:10] Software slave management
        SSM: u1 = 0,
        /// [10:11] Receive only
        RXONLY: u1 = 0,
        /// [11:12] Data frame format
        DFF: u1 = 0,
        /// [12:13] CRC transfer next
        CRCNEXT: u1 = 0,
        /// [13:14] Hardware CRC calculation enable
        CRCEN: u1 = 0,
        /// [14:15] Output enable in bidirectional mode
        BIDIOE: u1 = 0,
        /// [15:16] Bidirectional data mode enable
        BIDIMODE: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x04] control register 2
    CR2: r32(packed struct {
        /// [0:1] Rx buffer DMA enable
        RXDMAEN: u1 = 0,
        /// [1:2] Tx buffer DMA enable
        TXDMAEN: u1 = 0,
        /// [2:3] SS output enable
        SSOE: u1 = 0,
        _unused3: u1 = 0,
        /// [4:5] Frame format
        FRF: u1 = 0,
        /// [5:6] Error interrupt enable
        ERRIE: u1 = 0,
        /// [6:7] RX buffer not empty interrupt enable
        RXNEIE: u1 = 0,
        /// [7:8] Tx buffer empty interrupt enable
        TXEIE: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x08] status register
    SR: r32(packed struct {
        /// [0:1] Receive buffer not empty
        RXNE: u1 = 0,
        /// [1:2] Transmit buffer empty
        TXE: u1 = 0,
        /// [2:3] Channel side
        CHSIDE: u1 = 0,
        /// [3:4] Underrun flag
        UDR: u1 = 0,
        /// [4:5] CRC error flag
        CRCERR: u1 = 0,
        /// [5:6] Mode fault
        MODF: u1 = 0,
        /// [6:7] Overrun flag
        OVR: u1 = 0,
        /// [7:8] Busy flag
        BSY: u1 = 0,
        /// [8:9] TI frame format error
        TIFRFE: u1 = 0,
        _unused9: u23 = 0,
    }),
    /// [+0x0C] data register
    DR: r32(packed struct {
        /// [0:16] Data register
        DR: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] CRC polynomial register
    CRCPR: r32(packed struct {
        /// [0:16] CRC polynomial register
        CRCPOLY: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] RX CRC register
    RXCRCR: r32(packed struct {
        /// [0:16] Rx CRC register
        RxCRC: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x18] TX CRC register
    TXCRCR: r32(packed struct {
        /// [0:16] Tx CRC register
        TxCRC: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x1C] I2S configuration register
    I2SCFGR: r32(packed struct {
        /// [0:1] Channel length (number of bits per audio channel)
        CHLEN: u1 = 0,
        /// [1:3] Data length to be transferred
        DATLEN: u2 = 0,
        /// [3:4] Steady state clock polarity
        CKPOL: u1 = 0,
        /// [4:6] I2S standard selection
        I2SSTD: u2 = 0,
        _unused6: u1 = 0,
        /// [7:8] PCM frame synchronization
        PCMSYNC: u1 = 0,
        /// [8:10] I2S configuration mode
        I2SCFG: u2 = 0,
        /// [10:11] I2S Enable
        I2SE: u1 = 0,
        /// [11:12] I2S mode selection
        I2SMOD: u1 = 0,
        _unused12: u20 = 0,
    }),
    /// [+0x20] I2S prescaler register
    I2SPR: r32(packed struct {
        /// [0:8] I2S Linear prescaler
        I2SDIV: u8 = 0,
        /// [8:9] Odd factor for the prescaler
        ODD: u1 = 0,
        /// [9:10] Master clock output enable
        MCKOE: u1 = 0,
        _unused10: u22 = 0,
    }),
};

/// SysTick timer
pub const STK_Peripheral = packed struct {
    /// [+0x00] SysTick control and status register
    CSR: r32(packed struct {
        /// [0:1] Counter enable
        ENABLE: u1 = 0,
        /// [1:2] SysTick exception request enable
        TICKINT: u1 = 0,
        /// [2:3] Clock source selection
        CLKSOURCE: u1 = 0,
        _unused3: u13 = 0,
        /// [16:17] COUNTFLAG
        COUNTFLAG: u1 = 0,
        _unused17: u15 = 0,
    }),
    /// [+0x04] SysTick reload value register
    RVR: r32(packed struct {
        /// [0:24] RELOAD value
        RELOAD: u24 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x08] SysTick current value register
    CVR: r32(packed struct {
        /// [0:24] Current counter value
        CURRENT: u24 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x0C] SysTick calibration value register
    CALIB: r32(packed struct {
        /// [0:24] Calibration value
        TENMS: u24 = 0,
        _unused24: u6 = 0,
        /// [30:31] SKEW flag: Indicates whether the TENMS value is exact
        SKEW: u1 = 0,
        /// [31:32] NOREF flag. Reads as zero
        NOREF: u1 = 0,
    }),
};

/// System configuration controller and Comparator
pub const SYSCFG_COMP_Peripheral = packed struct {
    /// [+0x00] SYSCFG configuration register 1
    CFGR1: r32(packed struct {
        /// [0:2] Memory mapping selection bits
        MEM_MODE: u2 = 0,
        _unused2: u6 = 0,
        /// [8:10] Boot mode selected by the boot pins status bits
        BOOT_MODE: u2 = 0,
        _unused10: u22 = 0,
    }),
    /// [+0x04] SYSCFG configuration register 2
    CFGR2: r32(packed struct {
        /// [0:1] Firewall disable bit
        FWDISEN: u1 = 0,
        _unused1: u7 = 0,
        /// [8:9] Fm+ drive capability on PB6 enable bit
        I2C_PB6_FMP: u1 = 0,
        /// [9:10] Fm+ drive capability on PB7 enable bit
        I2C_PB7_FMP: u1 = 0,
        /// [10:11] Fm+ drive capability on PB8 enable bit
        I2C_PB8_FMP: u1 = 0,
        /// [11:12] Fm+ drive capability on PB9 enable bit
        I2C_PB9_FMP: u1 = 0,
        /// [12:13] I2C1 Fm+ drive capability enable bit
        I2C1_FMP: u1 = 0,
        /// [13:14] I2C2 Fm+ drive capability enable bit
        I2C2_FMP: u1 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x08] external interrupt configuration register 1
    EXTICR1: r32(packed struct {
        /// [0:4] EXTI x configuration (x = 0 to 3)
        EXTI0: u4 = 0,
        /// [4:8] EXTI x configuration (x = 0 to 3)
        EXTI1: u4 = 0,
        /// [8:12] EXTI x configuration (x = 0 to 3)
        EXTI2: u4 = 0,
        /// [12:16] EXTI x configuration (x = 0 to 3)
        EXTI3: u4 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x0C] external interrupt configuration register 2
    EXTICR2: r32(packed struct {
        /// [0:4] EXTI x configuration (x = 4 to 7)
        EXTI4: u4 = 0,
        /// [4:8] EXTI x configuration (x = 4 to 7)
        EXTI5: u4 = 0,
        /// [8:12] EXTI x configuration (x = 4 to 7)
        EXTI6: u4 = 0,
        /// [12:16] EXTI x configuration (x = 4 to 7)
        EXTI7: u4 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] external interrupt configuration register 3
    EXTICR3: r32(packed struct {
        /// [0:4] EXTI x configuration (x = 8 to 11)
        EXTI8: u4 = 0,
        /// [4:8] EXTI x configuration (x = 8 to 11)
        EXTI9: u4 = 0,
        /// [8:12] EXTI10
        EXTI10: u4 = 0,
        /// [12:16] EXTI x configuration (x = 8 to 11)
        EXTI11: u4 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] external interrupt configuration register 4
    EXTICR4: r32(packed struct {
        /// [0:4] EXTI12
        EXTI12: u4 = 0,
        /// [4:8] EXTI13
        EXTI13: u4 = 0,
        /// [8:12] EXTI14
        EXTI14: u4 = 0,
        /// [12:16] EXTI x configuration (x = 12 to 15)
        EXTI15: u4 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x18] Comparator 1 control and status register
    COMP1_CSR: r32(packed struct {
        /// [0:1] Comparator 1 enable bit
        COMP1EN: u1 = 0,
        _unused1: u3 = 0,
        /// [4:6] Comparator 1 Input Minus connection configuration bit
        COMP1INNSEL: u2 = 0,
        _unused6: u2 = 0,
        /// [8:9] Comparator 1 window mode selection bit
        COMP1WM: u1 = 0,
        _unused9: u3 = 0,
        /// [12:13] Comparator 1 LPTIM input propagation bit
        COMP1LPTIMIN1: u1 = 0,
        _unused13: u2 = 0,
        /// [15:16] Comparator 1 polarity selection bit
        COMP1POLARITY: u1 = 0,
        _unused16: u14 = 0,
        /// [30:31] Comparator 1 output status bit
        COMP1VALUE: u1 = 0,
        /// [31:32] COMP1_CSR register lock bit
        COMP1LOCK: u1 = 0,
    }),
    /// [+0x1C] Comparator 2 control and status register
    COMP2_CSR: r32(packed struct {
        /// [0:1] Comparator 2 enable bit
        COMP2EN: u1 = 0,
        _unused1: u2 = 0,
        /// [3:4] Comparator 2 power mode selection bit
        COMP2SPEED: u1 = 0,
        /// [4:7] Comparator 2 Input Minus connection configuration bit
        COMP2INNSEL: u3 = 0,
        _unused7: u1 = 0,
        /// [8:11] Comparator 2 Input Plus connection configuration bit
        COMP2INPSEL: u3 = 0,
        _unused11: u1 = 0,
        /// [12:13] Comparator 2 LPTIM input 2 propagation bit
        COMP2LPTIMIN2: u1 = 0,
        /// [13:14] Comparator 2 LPTIM input 1 propagation bit
        COMP2LPTIMIN1: u1 = 0,
        _unused14: u1 = 0,
        /// [15:16] Comparator 2 polarity selection bit
        COMP2POLARITY: u1 = 0,
        _unused16: u4 = 0,
        /// [20:21] Comparator 2 output status bit
        COMP2VALUE: u1 = 0,
        _unused21: u10 = 0,
        /// [31:32] COMP2_CSR register lock bit
        COMP2LOCK: u1 = 0,
    }),
    /// [+0x20] SYSCFG configuration register 3
    CFGR3: r32(packed struct {
        /// [0:1] Vref Enable bit
        EN_BGAP: u1 = 0,
        _unused1: u3 = 0,
        /// [4:6] BGAP_ADC connection bit
        SEL_VREF_OUT: u2 = 0,
        _unused6: u2 = 0,
        /// [8:9] VREFINT reference for ADC enable bit
        ENBUF_BGAP_ADC: u1 = 0,
        /// [9:10] Sensor reference for ADC enable bit
        ENBUF_SENSOR_ADC: u1 = 0,
        _unused10: u2 = 0,
        /// [12:13] VREFINT reference for comparator 2 enable bit
        ENBUF_VREFINT_COMP: u1 = 0,
        /// [13:14] VREFINT reference for 48 MHz RC oscillator enable bit
        ENREF_RC48MHz: u1 = 0,
        _unused14: u12 = 0,
        /// [26:27] VREFINT for 48 MHz RC oscillator ready flag
        REF_RC48MHz_RDYF: u1 = 0,
        /// [27:28] Sensor for ADC ready flag
        SENSOR_ADC_RDYF: u1 = 0,
        /// [28:29] VREFINT for ADC ready flag
        VREFINT_ADC_RDYF: u1 = 0,
        /// [29:30] VREFINT for comparator ready flag
        VREFINT_COMP_RDYF: u1 = 0,
        /// [30:31] VREFINT ready flag
        VREFINT_RDYF: u1 = 0,
        /// [31:32] REF_CTRL lock bit
        REF_LOCK: u1 = 0,
    }),
};

/// General-purpose-timers
pub const TIM_Peripheral = packed struct {
    /// [+0x00] control register 1
    CR1: r32(packed struct {
        /// [0:1] Counter enable
        CEN: u1 = 0,
        /// [1:2] Update disable
        UDIS: u1 = 0,
        /// [2:3] Update request source
        URS: u1 = 0,
        /// [3:4] One-pulse mode
        OPM: u1 = 0,
        /// [4:5] Direction
        DIR: u1 = 0,
        /// [5:7] Center-aligned mode selection
        CMS: u2 = 0,
        /// [7:8] Auto-reload preload enable
        ARPE: u1 = 0,
        /// [8:10] Clock division
        CKD: u2 = 0,
        _unused10: u22 = 0,
    }),
    /// [+0x04] control register 2
    CR2: r32(packed struct {
        _unused0: u3 = 0,
        /// [3:4] Capture/compare DMA selection
        CCDS: u1 = 0,
        /// [4:7] Master mode selection
        MMS: u3 = 0,
        /// [7:8] TI1 selection
        TI1S: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x08] slave mode control register
    SMCR: r32(packed struct {
        /// [0:3] Slave mode selection
        SMS: u3 = 0,
        _unused3: u1 = 0,
        /// [4:7] Trigger selection
        TS: u3 = 0,
        /// [7:8] Master/Slave mode
        MSM: u1 = 0,
        /// [8:12] External trigger filter
        ETF: u4 = 0,
        /// [12:14] External trigger prescaler
        ETPS: u2 = 0,
        /// [14:15] External clock enable
        ECE: u1 = 0,
        /// [15:16] External trigger polarity
        ETP: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x0C] DMA/Interrupt enable register
    DIER: r32(packed struct {
        /// [0:1] Update interrupt enable
        UIE: u1 = 0,
        /// [1:2] Capture/Compare 1 interrupt enable
        CC1IE: u1 = 0,
        /// [2:3] Capture/Compare 2 interrupt enable
        CC2IE: u1 = 0,
        /// [3:4] Capture/Compare 3 interrupt enable
        CC3IE: u1 = 0,
        /// [4:5] Capture/Compare 4 interrupt enable
        CC4IE: u1 = 0,
        _unused5: u1 = 0,
        /// [6:7] Trigger interrupt enable
        TIE: u1 = 0,
        _unused7: u1 = 0,
        /// [8:9] Update DMA request enable
        UDE: u1 = 0,
        /// [9:10] Capture/Compare 1 DMA request enable
        CC1DE: u1 = 0,
        /// [10:11] Capture/Compare 2 DMA request enable
        CC2DE: u1 = 0,
        /// [11:12] Capture/Compare 3 DMA request enable
        CC3DE: u1 = 0,
        /// [12:13] Capture/Compare 4 DMA request enable
        CC4DE: u1 = 0,
        _unused13: u1 = 0,
        /// [14:15] Trigger DMA request enable
        TDE: u1 = 0,
        _unused15: u17 = 0,
    }),
    /// [+0x10] status register
    SR: r32(packed struct {
        /// [0:1] Update interrupt flag
        UIF: u1 = 0,
        /// [1:2] Capture/compare 1 interrupt flag
        CC1IF: u1 = 0,
        /// [2:3] Capture/Compare 2 interrupt flag
        CC2IF: u1 = 0,
        /// [3:4] Capture/Compare 3 interrupt flag
        CC3IF: u1 = 0,
        /// [4:5] Capture/Compare 4 interrupt flag
        CC4IF: u1 = 0,
        _unused5: u1 = 0,
        /// [6:7] Trigger interrupt flag
        TIF: u1 = 0,
        _unused7: u2 = 0,
        /// [9:10] Capture/Compare 1 overcapture flag
        CC1OF: u1 = 0,
        /// [10:11] Capture/compare 2 overcapture flag
        CC2OF: u1 = 0,
        /// [11:12] Capture/Compare 3 overcapture flag
        CC3OF: u1 = 0,
        /// [12:13] Capture/Compare 4 overcapture flag
        CC4OF: u1 = 0,
        _unused13: u19 = 0,
    }),
    /// [+0x14] event generation register
    EGR: r32(packed struct {
        /// [0:1] Update generation
        UG: u1 = 0,
        /// [1:2] Capture/compare 1 generation
        CC1G: u1 = 0,
        /// [2:3] Capture/compare 2 generation
        CC2G: u1 = 0,
        /// [3:4] Capture/compare 3 generation
        CC3G: u1 = 0,
        /// [4:5] Capture/compare 4 generation
        CC4G: u1 = 0,
        _unused5: u1 = 0,
        /// [6:7] Trigger generation
        TG: u1 = 0,
        _unused7: u25 = 0,
    }),
    /// [+0x18] capture/compare mode register 1 (output mode)
    CCMR1: r32(packed struct {
        /// [0:2] Capture/Compare 1 selection
        CC1S: u2 = 0,
        /// [2:3] Output compare 1 fast enable
        OC1FE: u1 = 0,
        /// [3:4] Output compare 1 preload enable
        OC1PE: u1 = 0,
        /// [4:7] Output compare 1 mode
        OC1M: u3 = 0,
        /// [7:8] Output compare 1 clear enable
        OC1CE: u1 = 0,
        /// [8:10] Capture/Compare 2 selection
        CC2S: u2 = 0,
        /// [10:11] Output compare 2 fast enable
        OC2FE: u1 = 0,
        /// [11:12] Output compare 2 preload enable
        OC2PE: u1 = 0,
        /// [12:15] Output compare 2 mode
        OC2M: u3 = 0,
        /// [15:16] Output compare 2 clear enable
        OC2CE: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x1C] capture/compare mode register 2 (output mode)
    CCMR2: r32(packed struct {
        /// [0:2] Capture/Compare 3 selection
        CC3S: u2 = 0,
        /// [2:3] Output compare 3 fast enable
        OC3FE: u1 = 0,
        /// [3:4] Output compare 3 preload enable
        OC3PE: u1 = 0,
        /// [4:7] Output compare 3 mode
        OC3M: u3 = 0,
        /// [7:8] Output compare 3 clear enable
        OC3CE: u1 = 0,
        /// [8:10] Capture/Compare 4 selection
        CC4S: u2 = 0,
        /// [10:11] Output compare 4 fast enable
        OC4FE: u1 = 0,
        /// [11:12] Output compare 4 preload enable
        OC4PE: u1 = 0,
        /// [12:15] Output compare 4 mode
        OC4M: u3 = 0,
        /// [15:16] Output compare 4 clear enable
        OC4CE: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x20] capture/compare enable register
    CCER: r32(packed struct {
        /// [0:1] Capture/Compare 1 output enable
        CC1E: u1 = 0,
        /// [1:2] Capture/Compare 1 output Polarity
        CC1P: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] Capture/Compare 1 output Polarity
        CC1NP: u1 = 0,
        /// [4:5] Capture/Compare 2 output enable
        CC2E: u1 = 0,
        /// [5:6] Capture/Compare 2 output Polarity
        CC2P: u1 = 0,
        _unused6: u1 = 0,
        /// [7:8] Capture/Compare 2 output Polarity
        CC2NP: u1 = 0,
        /// [8:9] Capture/Compare 3 output enable
        CC3E: u1 = 0,
        /// [9:10] Capture/Compare 3 output Polarity
        CC3P: u1 = 0,
        _unused10: u1 = 0,
        /// [11:12] Capture/Compare 3 output Polarity
        CC3NP: u1 = 0,
        /// [12:13] Capture/Compare 4 output enable
        CC4E: u1 = 0,
        /// [13:14] Capture/Compare 3 output Polarity
        CC4P: u1 = 0,
        _unused14: u1 = 0,
        /// [15:16] Capture/Compare 4 output Polarity
        CC4NP: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x24] counter
    CNT: r32(packed struct {
        /// [0:16] Low counter value
        CNT_L: u16 = 0,
        /// [16:32] High counter value (TIM2 only)
        CNT_H: u16 = 0,
    }),
    /// [+0x28] prescaler
    PSC: r32(packed struct {
        /// [0:16] Prescaler value
        PSC: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x2C] auto-reload register
    ARR: r32(packed struct {
        /// [0:16] Low Auto-reload value
        ARR_L: u16 = 0,
        /// [16:32] High Auto-reload value (TIM2 only)
        ARR_H: u16 = 0,
    }),
    _unused48: u32,
    /// [+0x34] capture/compare register 1
    CCR1: r32(packed struct {
        /// [0:16] Low Capture/Compare 1 value
        CCR1_L: u16 = 0,
        /// [16:32] High Capture/Compare 1 value (TIM2 only)
        CCR1_H: u16 = 0,
    }),
    /// [+0x38] capture/compare register 2
    CCR2: r32(packed struct {
        /// [0:16] Low Capture/Compare 2 value
        CCR2_L: u16 = 0,
        /// [16:32] High Capture/Compare 2 value (TIM2 only)
        CCR2_H: u16 = 0,
    }),
    /// [+0x3C] capture/compare register 3
    CCR3: r32(packed struct {
        /// [0:16] Low Capture/Compare value
        CCR3_L: u16 = 0,
        /// [16:32] High Capture/Compare value (TIM2 only)
        CCR3_H: u16 = 0,
    }),
    /// [+0x40] capture/compare register 4
    CCR4: r32(packed struct {
        /// [0:16] Low Capture/Compare value
        CCR4_L: u16 = 0,
        /// [16:32] High Capture/Compare value (TIM2 only)
        CCR4_H: u16 = 0,
    }),
    _unused68: u32,
    /// [+0x48] DMA control register
    DCR: r32(packed struct {
        /// [0:5] DMA base address
        DBA: u5 = 0,
        _unused5: u3 = 0,
        /// [8:13] DMA burst length
        DBL: u5 = 0,
        _unused13: u19 = 0,
    }),
    /// [+0x4C] DMA address for full transfer
    DMAR: r32(packed struct {
        /// [0:16] DMA register for burst accesses
        DMAB: u16 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x50] TIM2 option register
    OR: r32(packed struct {
        /// [0:3] Timer2 ETR remap
        ETR_RMP: u3 = 0,
        /// [3:5] Internal trigger
        TI4_RMP: u2 = 0,
        _unused5: u27 = 0,
    }),
};

/// Touch sensing controller
pub const TSC_Peripheral = packed struct {
    /// [+0x00] control register
    CR: r32(packed struct {
        /// [0:1] Touch sensing controller enable
        TSCE: u1 = 0,
        /// [1:2] Start a new acquisition
        START: u1 = 0,
        /// [2:3] Acquisition mode
        AM: u1 = 0,
        /// [3:4] Synchronization pin polarity
        SYNCPOL: u1 = 0,
        /// [4:5] I/O Default mode
        IODEF: u1 = 0,
        /// [5:8] Max count value
        MCV: u3 = 0,
        _unused8: u4 = 0,
        /// [12:15] pulse generator prescaler
        PGPSC: u3 = 0,
        /// [15:16] Spread spectrum prescaler
        SSPSC: u1 = 0,
        /// [16:17] Spread spectrum enable
        SSE: u1 = 0,
        /// [17:24] Spread spectrum deviation
        SSD: u7 = 0,
        /// [24:28] Charge transfer pulse low
        CTPL: u4 = 0,
        /// [28:32] Charge transfer pulse high
        CTPH: u4 = 0,
    }),
    /// [+0x04] interrupt enable register
    IER: r32(packed struct {
        /// [0:1] End of acquisition interrupt enable
        EOAIE: u1 = 0,
        /// [1:2] Max count error interrupt enable
        MCEIE: u1 = 0,
        _unused2: u30 = 0,
    }),
    /// [+0x08] interrupt clear register
    ICR: r32(packed struct {
        /// [0:1] End of acquisition interrupt clear
        EOAIC: u1 = 0,
        /// [1:2] Max count error interrupt clear
        MCEIC: u1 = 0,
        _unused2: u30 = 0,
    }),
    /// [+0x0C] interrupt status register
    ISR: r32(packed struct {
        /// [0:1] End of acquisition flag
        EOAF: u1 = 0,
        /// [1:2] Max count error flag
        MCEF: u1 = 0,
        _unused2: u30 = 0,
    }),
    /// [+0x10] I/O hysteresis control register
    IOHCR: r32(packed struct {
        /// [0:1] G1_IO1
        G1_IO1: u1 = 0,
        /// [1:2] G1_IO2
        G1_IO2: u1 = 0,
        /// [2:3] G1_IO3
        G1_IO3: u1 = 0,
        /// [3:4] G1_IO4
        G1_IO4: u1 = 0,
        /// [4:5] G2_IO1
        G2_IO1: u1 = 0,
        /// [5:6] G2_IO2
        G2_IO2: u1 = 0,
        /// [6:7] G2_IO3
        G2_IO3: u1 = 0,
        /// [7:8] G2_IO4
        G2_IO4: u1 = 0,
        /// [8:9] G3_IO1
        G3_IO1: u1 = 0,
        /// [9:10] G3_IO2
        G3_IO2: u1 = 0,
        /// [10:11] G3_IO3
        G3_IO3: u1 = 0,
        /// [11:12] G3_IO4
        G3_IO4: u1 = 0,
        /// [12:13] G4_IO1
        G4_IO1: u1 = 0,
        /// [13:14] G4_IO2
        G4_IO2: u1 = 0,
        /// [14:15] G4_IO3
        G4_IO3: u1 = 0,
        /// [15:16] G4_IO4
        G4_IO4: u1 = 0,
        /// [16:17] G5_IO1
        G5_IO1: u1 = 0,
        /// [17:18] G5_IO2
        G5_IO2: u1 = 0,
        /// [18:19] G5_IO3
        G5_IO3: u1 = 0,
        /// [19:20] G5_IO4
        G5_IO4: u1 = 0,
        /// [20:21] G6_IO1
        G6_IO1: u1 = 0,
        /// [21:22] G6_IO2
        G6_IO2: u1 = 0,
        /// [22:23] G6_IO3
        G6_IO3: u1 = 0,
        /// [23:24] G6_IO4
        G6_IO4: u1 = 0,
        /// [24:25] G7_IO1
        G7_IO1: u1 = 0,
        /// [25:26] G7_IO2
        G7_IO2: u1 = 0,
        /// [26:27] G7_IO3
        G7_IO3: u1 = 0,
        /// [27:28] G7_IO4
        G7_IO4: u1 = 0,
        /// [28:29] G8_IO1
        G8_IO1: u1 = 0,
        /// [29:30] G8_IO2
        G8_IO2: u1 = 0,
        /// [30:31] G8_IO3
        G8_IO3: u1 = 0,
        /// [31:32] G8_IO4
        G8_IO4: u1 = 0,
    }),
    _unused20: u32,
    /// [+0x18] I/O analog switch control register
    IOASCR: r32(packed struct {
        /// [0:1] G1_IO1
        G1_IO1: u1 = 0,
        /// [1:2] G1_IO2
        G1_IO2: u1 = 0,
        /// [2:3] G1_IO3
        G1_IO3: u1 = 0,
        /// [3:4] G1_IO4
        G1_IO4: u1 = 0,
        /// [4:5] G2_IO1
        G2_IO1: u1 = 0,
        /// [5:6] G2_IO2
        G2_IO2: u1 = 0,
        /// [6:7] G2_IO3
        G2_IO3: u1 = 0,
        /// [7:8] G2_IO4
        G2_IO4: u1 = 0,
        /// [8:9] G3_IO1
        G3_IO1: u1 = 0,
        /// [9:10] G3_IO2
        G3_IO2: u1 = 0,
        /// [10:11] G3_IO3
        G3_IO3: u1 = 0,
        /// [11:12] G3_IO4
        G3_IO4: u1 = 0,
        /// [12:13] G4_IO1
        G4_IO1: u1 = 0,
        /// [13:14] G4_IO2
        G4_IO2: u1 = 0,
        /// [14:15] G4_IO3
        G4_IO3: u1 = 0,
        /// [15:16] G4_IO4
        G4_IO4: u1 = 0,
        /// [16:17] G5_IO1
        G5_IO1: u1 = 0,
        /// [17:18] G5_IO2
        G5_IO2: u1 = 0,
        /// [18:19] G5_IO3
        G5_IO3: u1 = 0,
        /// [19:20] G5_IO4
        G5_IO4: u1 = 0,
        /// [20:21] G6_IO1
        G6_IO1: u1 = 0,
        /// [21:22] G6_IO2
        G6_IO2: u1 = 0,
        /// [22:23] G6_IO3
        G6_IO3: u1 = 0,
        /// [23:24] G6_IO4
        G6_IO4: u1 = 0,
        /// [24:25] G7_IO1
        G7_IO1: u1 = 0,
        /// [25:26] G7_IO2
        G7_IO2: u1 = 0,
        /// [26:27] G7_IO3
        G7_IO3: u1 = 0,
        /// [27:28] G7_IO4
        G7_IO4: u1 = 0,
        /// [28:29] G8_IO1
        G8_IO1: u1 = 0,
        /// [29:30] G8_IO2
        G8_IO2: u1 = 0,
        /// [30:31] G8_IO3
        G8_IO3: u1 = 0,
        /// [31:32] G8_IO4
        G8_IO4: u1 = 0,
    }),
    _unused28: u32,
    /// [+0x20] I/O sampling control register
    IOSCR: r32(packed struct {
        /// [0:1] G1_IO1
        G1_IO1: u1 = 0,
        /// [1:2] G1_IO2
        G1_IO2: u1 = 0,
        /// [2:3] G1_IO3
        G1_IO3: u1 = 0,
        /// [3:4] G1_IO4
        G1_IO4: u1 = 0,
        /// [4:5] G2_IO1
        G2_IO1: u1 = 0,
        /// [5:6] G2_IO2
        G2_IO2: u1 = 0,
        /// [6:7] G2_IO3
        G2_IO3: u1 = 0,
        /// [7:8] G2_IO4
        G2_IO4: u1 = 0,
        /// [8:9] G3_IO1
        G3_IO1: u1 = 0,
        /// [9:10] G3_IO2
        G3_IO2: u1 = 0,
        /// [10:11] G3_IO3
        G3_IO3: u1 = 0,
        /// [11:12] G3_IO4
        G3_IO4: u1 = 0,
        /// [12:13] G4_IO1
        G4_IO1: u1 = 0,
        /// [13:14] G4_IO2
        G4_IO2: u1 = 0,
        /// [14:15] G4_IO3
        G4_IO3: u1 = 0,
        /// [15:16] G4_IO4
        G4_IO4: u1 = 0,
        /// [16:17] G5_IO1
        G5_IO1: u1 = 0,
        /// [17:18] G5_IO2
        G5_IO2: u1 = 0,
        /// [18:19] G5_IO3
        G5_IO3: u1 = 0,
        /// [19:20] G5_IO4
        G5_IO4: u1 = 0,
        /// [20:21] G6_IO1
        G6_IO1: u1 = 0,
        /// [21:22] G6_IO2
        G6_IO2: u1 = 0,
        /// [22:23] G6_IO3
        G6_IO3: u1 = 0,
        /// [23:24] G6_IO4
        G6_IO4: u1 = 0,
        /// [24:25] G7_IO1
        G7_IO1: u1 = 0,
        /// [25:26] G7_IO2
        G7_IO2: u1 = 0,
        /// [26:27] G7_IO3
        G7_IO3: u1 = 0,
        /// [27:28] G7_IO4
        G7_IO4: u1 = 0,
        /// [28:29] G8_IO1
        G8_IO1: u1 = 0,
        /// [29:30] G8_IO2
        G8_IO2: u1 = 0,
        /// [30:31] G8_IO3
        G8_IO3: u1 = 0,
        /// [31:32] G8_IO4
        G8_IO4: u1 = 0,
    }),
    _unused36: u32,
    /// [+0x28] I/O channel control register
    IOCCR: r32(packed struct {
        /// [0:1] G1_IO1
        G1_IO1: u1 = 0,
        /// [1:2] G1_IO2
        G1_IO2: u1 = 0,
        /// [2:3] G1_IO3
        G1_IO3: u1 = 0,
        /// [3:4] G1_IO4
        G1_IO4: u1 = 0,
        /// [4:5] G2_IO1
        G2_IO1: u1 = 0,
        /// [5:6] G2_IO2
        G2_IO2: u1 = 0,
        /// [6:7] G2_IO3
        G2_IO3: u1 = 0,
        /// [7:8] G2_IO4
        G2_IO4: u1 = 0,
        /// [8:9] G3_IO1
        G3_IO1: u1 = 0,
        /// [9:10] G3_IO2
        G3_IO2: u1 = 0,
        /// [10:11] G3_IO3
        G3_IO3: u1 = 0,
        /// [11:12] G3_IO4
        G3_IO4: u1 = 0,
        /// [12:13] G4_IO1
        G4_IO1: u1 = 0,
        /// [13:14] G4_IO2
        G4_IO2: u1 = 0,
        /// [14:15] G4_IO3
        G4_IO3: u1 = 0,
        /// [15:16] G4_IO4
        G4_IO4: u1 = 0,
        /// [16:17] G5_IO1
        G5_IO1: u1 = 0,
        /// [17:18] G5_IO2
        G5_IO2: u1 = 0,
        /// [18:19] G5_IO3
        G5_IO3: u1 = 0,
        /// [19:20] G5_IO4
        G5_IO4: u1 = 0,
        /// [20:21] G6_IO1
        G6_IO1: u1 = 0,
        /// [21:22] G6_IO2
        G6_IO2: u1 = 0,
        /// [22:23] G6_IO3
        G6_IO3: u1 = 0,
        /// [23:24] G6_IO4
        G6_IO4: u1 = 0,
        /// [24:25] G7_IO1
        G7_IO1: u1 = 0,
        /// [25:26] G7_IO2
        G7_IO2: u1 = 0,
        /// [26:27] G7_IO3
        G7_IO3: u1 = 0,
        /// [27:28] G7_IO4
        G7_IO4: u1 = 0,
        /// [28:29] G8_IO1
        G8_IO1: u1 = 0,
        /// [29:30] G8_IO2
        G8_IO2: u1 = 0,
        /// [30:31] G8_IO3
        G8_IO3: u1 = 0,
        /// [31:32] G8_IO4
        G8_IO4: u1 = 0,
    }),
    _unused44: u32,
    /// [+0x30] I/O group control status register
    IOGCSR: r32(packed struct {
        /// [0:1] Analog I/O group x enable
        G1E: u1 = 0,
        /// [1:2] Analog I/O group x enable
        G2E: u1 = 0,
        /// [2:3] Analog I/O group x enable
        G3E: u1 = 0,
        /// [3:4] Analog I/O group x enable
        G4E: u1 = 0,
        /// [4:5] Analog I/O group x enable
        G5E: u1 = 0,
        /// [5:6] Analog I/O group x enable
        G6E: u1 = 0,
        /// [6:7] Analog I/O group x enable
        G7E: u1 = 0,
        /// [7:8] Analog I/O group x enable
        G8E: u1 = 0,
        _unused8: u8 = 0,
        /// [16:17] Analog I/O group x status
        G1S: u1 = 0,
        /// [17:18] Analog I/O group x status
        G2S: u1 = 0,
        /// [18:19] Analog I/O group x status
        G3S: u1 = 0,
        /// [19:20] Analog I/O group x status
        G4S: u1 = 0,
        /// [20:21] Analog I/O group x status
        G5S: u1 = 0,
        /// [21:22] Analog I/O group x status
        G6S: u1 = 0,
        /// [22:23] Analog I/O group x status
        G7S: u1 = 0,
        /// [23:24] Analog I/O group x status
        G8S: u1 = 0,
        _unused24: u8 = 0,
    }),
    /// [+0x34] I/O group x counter register
    IOG1CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x38] I/O group x counter register
    IOG2CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x3C] I/O group x counter register
    IOG3CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x40] I/O group x counter register
    IOG4CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x44] I/O group x counter register
    IOG5CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x48] I/O group x counter register
    IOG6CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x4C] I/O group x counter register
    IOG7CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
    /// [+0x50] I/O group x counter register
    IOG8CR: r32(packed struct {
        /// [0:14] Counter value
        CNT: u14 = 0,
        _unused14: u18 = 0,
    }),
};

/// Universal synchronous asynchronous receiver transmitter
pub const USART_Peripheral = packed struct {
    /// [+0x00] Control register 1
    CR1: r32(packed struct {
        /// [0:1] USART enable
        UE: u1 = 0,
        /// [1:2] USART enable in Stop mode
        UESM: u1 = 0,
        /// [2:3] Receiver enable
        RE: u1 = 0,
        /// [3:4] Transmitter enable
        TE: u1 = 0,
        /// [4:5] IDLE interrupt enable
        IDLEIE: u1 = 0,
        /// [5:6] RXNE interrupt enable
        RXNEIE: u1 = 0,
        /// [6:7] Transmission complete interrupt enable
        TCIE: u1 = 0,
        /// [7:8] interrupt enable
        TXEIE: u1 = 0,
        /// [8:9] PE interrupt enable
        PEIE: u1 = 0,
        /// [9:10] Parity selection
        PS: u1 = 0,
        /// [10:11] Parity control enable
        PCE: u1 = 0,
        /// [11:12] Receiver wakeup method
        WAKE: u1 = 0,
        /// [12:13] Word length
        M0: u1 = 0,
        /// [13:14] Mute mode enable
        MME: u1 = 0,
        /// [14:15] Character match interrupt enable
        CMIE: u1 = 0,
        /// [15:16] Oversampling mode
        OVER8: u1 = 0,
        /// [16:17] DEDT0
        DEDT0: u1 = 0,
        /// [17:18] DEDT1
        DEDT1: u1 = 0,
        /// [18:19] DEDT2
        DEDT2: u1 = 0,
        /// [19:20] DEDT3
        DEDT3: u1 = 0,
        /// [20:21] Driver Enable de-assertion time
        DEDT4: u1 = 0,
        /// [21:22] DEAT0
        DEAT0: u1 = 0,
        /// [22:23] DEAT1
        DEAT1: u1 = 0,
        /// [23:24] DEAT2
        DEAT2: u1 = 0,
        /// [24:25] DEAT3
        DEAT3: u1 = 0,
        /// [25:26] Driver Enable assertion time
        DEAT4: u1 = 0,
        /// [26:27] Receiver timeout interrupt enable
        RTOIE: u1 = 0,
        /// [27:28] End of Block interrupt enable
        EOBIE: u1 = 0,
        /// [28:29] Word length
        M1: u1 = 0,
        _unused29: u3 = 0,
    }),
    /// [+0x04] Control register 2
    CR2: r32(packed struct {
        _unused0: u4 = 0,
        /// [4:5] 7-bit Address Detection/4-bit Address Detection
        ADDM7: u1 = 0,
        /// [5:6] LIN break detection length
        LBDL: u1 = 0,
        /// [6:7] LIN break detection interrupt enable
        LBDIE: u1 = 0,
        _unused7: u1 = 0,
        /// [8:9] Last bit clock pulse
        LBCL: u1 = 0,
        /// [9:10] Clock phase
        CPHA: u1 = 0,
        /// [10:11] Clock polarity
        CPOL: u1 = 0,
        /// [11:12] Clock enable
        CLKEN: u1 = 0,
        /// [12:14] STOP bits
        STOP: u2 = 0,
        /// [14:15] LIN mode enable
        LINEN: u1 = 0,
        /// [15:16] Swap TX/RX pins
        SWAP: u1 = 0,
        /// [16:17] RX pin active level inversion
        RXINV: u1 = 0,
        /// [17:18] TX pin active level inversion
        TXINV: u1 = 0,
        /// [18:19] Binary data inversion
        TAINV: u1 = 0,
        /// [19:20] Most significant bit first
        MSBFIRST: u1 = 0,
        /// [20:21] Auto baud rate enable
        ABREN: u1 = 0,
        /// [21:22] ABRMOD0
        ABRMOD0: u1 = 0,
        /// [22:23] Auto baud rate mode
        ABRMOD1: u1 = 0,
        /// [23:24] Receiver timeout enable
        RTOEN: u1 = 0,
        /// [24:28] Address of the USART node
        ADD0_3: u4 = 0,
        /// [28:32] Address of the USART node
        ADD4_7: u4 = 0,
    }),
    /// [+0x08] Control register 3
    CR3: r32(packed struct {
        /// [0:1] Error interrupt enable
        EIE: u1 = 0,
        /// [1:2] Ir mode enable
        IREN: u1 = 0,
        /// [2:3] Ir low-power
        IRLP: u1 = 0,
        /// [3:4] Half-duplex selection
        HDSEL: u1 = 0,
        /// [4:5] Smartcard NACK enable
        NACK: u1 = 0,
        /// [5:6] Smartcard mode enable
        SCEN: u1 = 0,
        /// [6:7] DMA enable receiver
        DMAR: u1 = 0,
        /// [7:8] DMA enable transmitter
        DMAT: u1 = 0,
        /// [8:9] RTS enable
        RTSE: u1 = 0,
        /// [9:10] CTS enable
        CTSE: u1 = 0,
        /// [10:11] CTS interrupt enable
        CTSIE: u1 = 0,
        /// [11:12] One sample bit method enable
        ONEBIT: u1 = 0,
        /// [12:13] Overrun Disable
        OVRDIS: u1 = 0,
        /// [13:14] DMA Disable on Reception Error
        DDRE: u1 = 0,
        /// [14:15] Driver enable mode
        DEM: u1 = 0,
        /// [15:16] Driver enable polarity selection
        DEP: u1 = 0,
        _unused16: u1 = 0,
        /// [17:20] Smartcard auto-retry count
        SCARCNT: u3 = 0,
        /// [20:22] Wakeup from Stop mode interrupt flag selection
        WUS: u2 = 0,
        /// [22:23] Wakeup from Stop mode interrupt enable
        WUFIE: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x0C] Baud rate register
    BRR: r32(packed struct {
        /// [0:4] DIV_Fraction
        DIV_Fraction: u4 = 0,
        /// [4:16] DIV_Mantissa
        DIV_Mantissa: u12 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] Guard time and prescaler register
    GTPR: r32(packed struct {
        /// [0:8] Prescaler value
        PSC: u8 = 0,
        /// [8:16] Guard time value
        GT: u8 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] Receiver timeout register
    RTOR: r32(packed struct {
        /// [0:24] Receiver timeout value
        RTO: u24 = 0,
        /// [24:32] Block Length
        BLEN: u8 = 0,
    }),
    /// [+0x18] Request register
    RQR: r32(packed struct {
        /// [0:1] Auto baud rate request
        ABRRQ: u1 = 0,
        /// [1:2] Send break request
        SBKRQ: u1 = 0,
        /// [2:3] Mute mode request
        MMRQ: u1 = 0,
        /// [3:4] Receive data flush request
        RXFRQ: u1 = 0,
        /// [4:5] Transmit data flush request
        TXFRQ: u1 = 0,
        _unused5: u27 = 0,
    }),
    /// [+0x1C] Interrupt & status register
    ISR: r32(packed struct {
        /// [0:1] PE
        PE: u1 = 0,
        /// [1:2] FE
        FE: u1 = 0,
        /// [2:3] NF
        NF: u1 = 0,
        /// [3:4] ORE
        ORE: u1 = 0,
        /// [4:5] IDLE
        IDLE: u1 = 0,
        /// [5:6] RXNE
        RXNE: u1 = 0,
        /// [6:7] TC
        TC: u1 = 0,
        /// [7:8] TXE
        TXE: u1 = 0,
        /// [8:9] LBDF
        LBDF: u1 = 0,
        /// [9:10] CTSIF
        CTSIF: u1 = 0,
        /// [10:11] CTS
        CTS: u1 = 0,
        /// [11:12] RTOF
        RTOF: u1 = 0,
        /// [12:13] EOBF
        EOBF: u1 = 0,
        _unused13: u1 = 0,
        /// [14:15] ABRE
        ABRE: u1 = 0,
        /// [15:16] ABRF
        ABRF: u1 = 0,
        /// [16:17] BUSY
        BUSY: u1 = 0,
        /// [17:18] CMF
        CMF: u1 = 0,
        /// [18:19] SBKF
        SBKF: u1 = 0,
        /// [19:20] RWU
        RWU: u1 = 0,
        /// [20:21] WUF
        WUF: u1 = 0,
        /// [21:22] TEACK
        TEACK: u1 = 0,
        /// [22:23] REACK
        REACK: u1 = 0,
        _unused23: u9 = 0,
    }),
    /// [+0x20] Interrupt flag clear register
    ICR: r32(packed struct {
        /// [0:1] Parity error clear flag
        PECF: u1 = 0,
        /// [1:2] Framing error clear flag
        FECF: u1 = 0,
        /// [2:3] Noise detected clear flag
        NCF: u1 = 0,
        /// [3:4] Overrun error clear flag
        ORECF: u1 = 0,
        /// [4:5] Idle line detected clear flag
        IDLECF: u1 = 0,
        _unused5: u1 = 0,
        /// [6:7] Transmission complete clear flag
        TCCF: u1 = 0,
        _unused7: u1 = 0,
        /// [8:9] LIN break detection clear flag
        LBDCF: u1 = 0,
        /// [9:10] CTS clear flag
        CTSCF: u1 = 0,
        _unused10: u1 = 0,
        /// [11:12] Receiver timeout clear flag
        RTOCF: u1 = 0,
        /// [12:13] End of block clear flag
        EOBCF: u1 = 0,
        _unused13: u4 = 0,
        /// [17:18] Character match clear flag
        CMCF: u1 = 0,
        _unused18: u2 = 0,
        /// [20:21] Wakeup from Stop mode clear flag
        WUCF: u1 = 0,
        _unused21: u11 = 0,
    }),
    /// [+0x24] Receive data register
    RDR: r32(packed struct {
        /// [0:9] Receive data value
        RDR: u9 = 0,
        _unused9: u23 = 0,
    }),
    /// [+0x28] Transmit data register
    TDR: r32(packed struct {
        /// [0:9] Transmit data value
        TDR: u9 = 0,
        _unused9: u23 = 0,
    }),
};

/// Universal serial bus full-speed device interface
pub const USB_FS_Peripheral = packed struct {
    /// [+0x00] endpoint register
    EP0R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x04] endpoint register
    EP1R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x08] endpoint register
    EP2R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x0C] endpoint register
    EP3R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] endpoint register
    EP4R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] endpoint register
    EP5R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x18] endpoint register
    EP6R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x1C] endpoint register
    EP7R: r32(packed struct {
        /// [0:4] EA
        EA: u4 = 0,
        /// [4:6] STAT_TX
        STAT_TX: u2 = 0,
        /// [6:7] DTOG_TX
        DTOG_TX: u1 = 0,
        /// [7:8] CTR_TX
        CTR_TX: u1 = 0,
        /// [8:9] EP_KIND
        EP_KIND: u1 = 0,
        /// [9:11] EPTYPE
        EPTYPE: u2 = 0,
        /// [11:12] SETUP
        SETUP: u1 = 0,
        /// [12:14] STAT_RX
        STAT_RX: u2 = 0,
        /// [14:15] DTOG_RX
        DTOG_RX: u1 = 0,
        /// [15:16] CTR_RX
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    _unused32: [32]u8,
    /// [+0x40] control register
    CNTR: r32(packed struct {
        /// [0:1] FRES
        FRES: u1 = 0,
        /// [1:2] PDWN
        PDWN: u1 = 0,
        /// [2:3] LPMODE
        LPMODE: u1 = 0,
        /// [3:4] FSUSP
        FSUSP: u1 = 0,
        /// [4:5] RESUME
        RESUME: u1 = 0,
        /// [5:6] L1RESUME
        L1RESUME: u1 = 0,
        _unused6: u1 = 0,
        /// [7:8] L1REQM
        L1REQM: u1 = 0,
        /// [8:9] ESOFM
        ESOFM: u1 = 0,
        /// [9:10] SOFM
        SOFM: u1 = 0,
        /// [10:11] RESETM
        RESETM: u1 = 0,
        /// [11:12] SUSPM
        SUSPM: u1 = 0,
        /// [12:13] WKUPM
        WKUPM: u1 = 0,
        /// [13:14] ERRM
        ERRM: u1 = 0,
        /// [14:15] PMAOVRM
        PMAOVRM: u1 = 0,
        /// [15:16] CTRM
        CTRM: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x44] interrupt status register
    ISTR: r32(packed struct {
        /// [0:4] EP_ID
        EP_ID: u4 = 0,
        /// [4:5] DIR
        DIR: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] L1REQ
        L1REQ: u1 = 0,
        /// [8:9] ESOF
        ESOF: u1 = 0,
        /// [9:10] SOF
        SOF: u1 = 0,
        /// [10:11] RESET
        RESET: u1 = 0,
        /// [11:12] SUSP
        SUSP: u1 = 0,
        /// [12:13] WKUP
        WKUP: u1 = 0,
        /// [13:14] ERR
        ERR: u1 = 0,
        /// [14:15] PMAOVR
        PMAOVR: u1 = 0,
        /// [15:16] CTR
        CTR: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x48] frame number register
    FNR: r32(packed struct {
        /// [0:11] FN
        FN: u11 = 0,
        /// [11:13] LSOF
        LSOF: u2 = 0,
        /// [13:14] LCK
        LCK: u1 = 0,
        /// [14:15] RXDM
        RXDM: u1 = 0,
        /// [15:16] RXDP
        RXDP: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x4C] device address
    DADDR: r32(packed struct {
        /// [0:7] ADD
        ADD: u7 = 0,
        /// [7:8] EF
        EF: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x50] Buffer table address
    BTABLE: r32(packed struct {
        _unused0: u3 = 0,
        /// [3:16] BTABLE
        BTABLE: u13 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x54] LPM control and status register
    LPMCSR: r32(packed struct {
        /// [0:1] LPMEN
        LPMEN: u1 = 0,
        /// [1:2] LPMACK
        LPMACK: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] REMWAKE
        REMWAKE: u1 = 0,
        /// [4:8] BESL
        BESL: u4 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x58] Battery charging detector
    BCDR: r32(packed struct {
        /// [0:1] BCDEN
        BCDEN: u1 = 0,
        /// [1:2] DCDEN
        DCDEN: u1 = 0,
        /// [2:3] PDEN
        PDEN: u1 = 0,
        /// [3:4] SDEN
        SDEN: u1 = 0,
        /// [4:5] DCDET
        DCDET: u1 = 0,
        /// [5:6] PDET
        PDET: u1 = 0,
        /// [6:7] SDET
        SDET: u1 = 0,
        /// [7:8] PS2DET
        PS2DET: u1 = 0,
        _unused8: u7 = 0,
        /// [15:16] DPPU
        DPPU: u1 = 0,
        _unused16: u16 = 0,
    }),
};

/// Universal serial bus full-speed device interface
pub const USB_SRAM_Peripheral = packed struct {
    /// [+0x00] endpoint 0 register
    EP0R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x04] endpoint 1 register
    EP1R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x08] endpoint 2 register
    EP2R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x0C] endpoint 3 register
    EP3R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x10] endpoint 4 register
    EP4R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x14] endpoint 5 register
    EP5R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x18] endpoint 6 register
    EP6R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x1C] endpoint 7 register
    EP7R: r32(packed struct {
        /// [0:4] Endpoint address
        EA: u4 = 0,
        /// [4:6] Status bits, for transmission transfers
        STAT_TX: u2 = 0,
        /// [6:7] Data Toggle, for transmission transfers
        DTOG_TX: u1 = 0,
        /// [7:8] Correct Transfer for transmission
        CTR_TX: u1 = 0,
        /// [8:9] Endpoint kind
        EP_KIND: u1 = 0,
        /// [9:11] Endpoint type
        EP_TYPE: u2 = 0,
        /// [11:12] Setup transaction completed
        SETUP: u1 = 0,
        /// [12:14] Status bits, for reception transfers
        STAT_RX: u2 = 0,
        /// [14:15] Data Toggle, for reception transfers
        DTOG_RX: u1 = 0,
        /// [15:16] Correct transfer for reception
        CTR_RX: u1 = 0,
        _unused16: u16 = 0,
    }),
    _unused32: [32]u8,
    /// [+0x40] control register
    CNTR: r32(packed struct {
        /// [0:1] Force USB Reset
        FRES: u1 = 0,
        /// [1:2] Power down
        PDWN: u1 = 0,
        /// [2:3] Low-power mode
        LPMODE: u1 = 0,
        /// [3:4] Force suspend
        FSUSP: u1 = 0,
        /// [4:5] Resume request
        RESUME: u1 = 0,
        /// [5:6] LPM L1 Resume request
        L1RESUME: u1 = 0,
        _unused6: u1 = 0,
        /// [7:8] LPM L1 state request interrupt mask
        L1REQM: u1 = 0,
        /// [8:9] Expected start of frame interrupt mask
        ESOFM: u1 = 0,
        /// [9:10] Start of frame interrupt mask
        SOFM: u1 = 0,
        /// [10:11] USB reset interrupt mask
        RESETM: u1 = 0,
        /// [11:12] Suspend mode interrupt mask
        SUSPM: u1 = 0,
        /// [12:13] Wakeup interrupt mask
        WKUPM: u1 = 0,
        /// [13:14] Error interrupt mask
        ERRM: u1 = 0,
        /// [14:15] Packet memory area over / underrun interrupt mask
        PMAOVRM: u1 = 0,
        /// [15:16] Correct transfer interrupt mask
        CTRM: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x44] interrupt status register
    ISTR: r32(packed struct {
        /// [0:4] Endpoint Identifier
        EP_ID: u4 = 0,
        /// [4:5] Direction of transaction
        DIR: u1 = 0,
        _unused5: u2 = 0,
        /// [7:8] LPM L1 state request
        L1REQ: u1 = 0,
        /// [8:9] Expected start frame
        ESOF: u1 = 0,
        /// [9:10] start of frame
        SOF: u1 = 0,
        /// [10:11] reset request
        RESET: u1 = 0,
        /// [11:12] Suspend mode request
        SUSP: u1 = 0,
        /// [12:13] Wakeup
        WKUP: u1 = 0,
        /// [13:14] Error
        ERR: u1 = 0,
        /// [14:15] Packet memory area over / underrun
        PMAOVR: u1 = 0,
        /// [15:16] Correct transfer
        CTR: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x48] frame number register
    FNR: r32(packed struct {
        /// [0:11] Frame number
        FN: u11 = 0,
        /// [11:13] Lost SOF
        LSOF: u2 = 0,
        /// [13:14] Locked
        LCK: u1 = 0,
        /// [14:15] Receive data - line status
        RXDM: u1 = 0,
        /// [15:16] Receive data + line status
        RXDP: u1 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x4C] device address
    DADDR: r32(packed struct {
        /// [0:7] Device address
        ADD: u7 = 0,
        /// [7:8] Enable function
        EF: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x50] Buffer table address
    BTABLE: r32(packed struct {
        _unused0: u3 = 0,
        /// [3:16] Buffer table
        BTABLE: u13 = 0,
        _unused16: u16 = 0,
    }),
    /// [+0x54] LPM control and status register
    LPMCSR: r32(packed struct {
        /// [0:1] LPM support enable
        LPMEN: u1 = 0,
        /// [1:2] LPM Token acknowledge enable
        LPMACK: u1 = 0,
        _unused2: u1 = 0,
        /// [3:4] bRemoteWake value
        REMWAKE: u1 = 0,
        /// [4:8] BESL value
        BESL: u4 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x58] Battery charging detector
    BCDR: r32(packed struct {
        /// [0:1] Battery charging detector
        BCDEN: u1 = 0,
        /// [1:2] Data contact detection
        DCDEN: u1 = 0,
        /// [2:3] Primary detection
        PDEN: u1 = 0,
        /// [3:4] Secondary detection
        SDEN: u1 = 0,
        /// [4:5] Data contact detection
        DCDET: u1 = 0,
        /// [5:6] Primary detection
        PDET: u1 = 0,
        /// [6:7] Secondary detection
        SDET: u1 = 0,
        /// [7:8] DM pull-up detection status
        PS2DET: u1 = 0,
        _unused8: u7 = 0,
        /// [15:16] DP pull-up control
        DPPU: u1 = 0,
        _unused16: u16 = 0,
    }),
};

/// System window watchdog
pub const WWDG_Peripheral = packed struct {
    /// [+0x00] Control register
    CR: r32(packed struct {
        /// [0:7] 7-bit counter (MSB to LSB)
        T: u7 = 0,
        /// [7:8] Activation bit
        WDGA: u1 = 0,
        _unused8: u24 = 0,
    }),
    /// [+0x04] Configuration register
    CFR: r32(packed struct {
        /// [0:7] 7-bit window value
        W: u7 = 0,
        /// [7:8] WDGTB0
        WDGTB0: u1 = 0,
        /// [8:9] Timer base
        WDGTB1: u1 = 0,
        /// [9:10] Early wakeup interrupt
        EWI: u1 = 0,
        _unused10: u22 = 0,
    }),
    /// [+0x08] Status register
    SR: r32(packed struct {
        /// [0:1] Early wakeup interrupt flag
        EWIF: u1 = 0,
        _unused1: u31 = 0,
    }),
};

pub const ADC: *volatile ADC_Peripheral = @ptrFromInt(0x40012400);
pub const AES: *volatile AES_Peripheral = @ptrFromInt(0x40026000);
pub const CRC: *volatile CRC_Peripheral = @ptrFromInt(0x40023000);
pub const CRS: *volatile CRS_Peripheral = @ptrFromInt(0x40006C00);
pub const DAC: *volatile DAC_Peripheral = @ptrFromInt(0x40007400);
pub const DBGMCU: *volatile DBGMCU_Peripheral = @ptrFromInt(0x40015800);
pub const DMA1: *volatile DMA_Peripheral = @ptrFromInt(0x40020000);
pub const EXTI: *volatile EXTI_Peripheral = @ptrFromInt(0x40010400);
pub const FIREWALL: *volatile FIREWALL_Peripheral = @ptrFromInt(0x40011C00);
pub const FLASH: *volatile FLASH_Peripheral = @ptrFromInt(0x40022000);
pub const GPIOA: *volatile GPIO_Peripheral = @ptrFromInt(0x50000000);
pub const GPIOB: *volatile GPIO_Peripheral = @ptrFromInt(0x50000400);
pub const GPIOC: *volatile GPIO_Peripheral = @ptrFromInt(0x50000800);
pub const GPIOD: *volatile GPIO_Peripheral = @ptrFromInt(0x50000C00);
pub const GPIOE: *volatile GPIO_Peripheral = @ptrFromInt(0x50001000);
pub const GPIOH: *volatile GPIO_Peripheral = @ptrFromInt(0x50001C00);
pub const I2C1: *volatile I2C_Peripheral = @ptrFromInt(0x40005400);
pub const I2C2: *volatile I2C_Peripheral = @ptrFromInt(0x40005800);
pub const I2C3: *volatile I2C_Peripheral = @ptrFromInt(0x40007800);
pub const IWDG: *volatile IWDG_Peripheral = @ptrFromInt(0x40003000);
pub const LCD: *volatile LCD_Peripheral = @ptrFromInt(0x40002400);
pub const LPTIM: *volatile LPTIM_Peripheral = @ptrFromInt(0x40007C00);
pub const LPUSART1: *volatile LPUSART_Peripheral = @ptrFromInt(0x40004800);
pub const MPU: *volatile MPU_Peripheral = @ptrFromInt(0xE000ED90);
pub const NVIC: *volatile NVIC_Peripheral = @ptrFromInt(0xE000E100);
pub const PWR: *volatile PWR_Peripheral = @ptrFromInt(0x40007000);
pub const RCC: *volatile RCC_Peripheral = @ptrFromInt(0x40021000);
pub const RNG: *volatile RNG_Peripheral = @ptrFromInt(0x40025000);
pub const RTC: *volatile RTC_Peripheral = @ptrFromInt(0x40002800);
pub const SCB: *volatile SCB_Peripheral = @ptrFromInt(0xE000ED00);
pub const SPI1: *volatile SPI_Peripheral = @ptrFromInt(0x40013000);
pub const SPI2: *volatile SPI_Peripheral = @ptrFromInt(0x40003800);
pub const STK: *volatile STK_Peripheral = @ptrFromInt(0xE000E010);
pub const SYSCFG_COMP: *volatile SYSCFG_COMP_Peripheral = @ptrFromInt(0x40010000);
pub const TIM2: *volatile TIM_Peripheral = @ptrFromInt(0x40000000);
pub const TIM21: *volatile TIM_Peripheral = @ptrFromInt(0x40010800);
pub const TIM22: *volatile TIM_Peripheral = @ptrFromInt(0x40011400);
pub const TIM3: *volatile TIM_Peripheral = @ptrFromInt(0x40000400);
pub const TIM6: *volatile TIM_Peripheral = @ptrFromInt(0x40001000);
pub const TIM7: *volatile TIM_Peripheral = @ptrFromInt(0x40001400);
pub const TSC: *volatile TSC_Peripheral = @ptrFromInt(0x40024000);
pub const USART1: *volatile USART_Peripheral = @ptrFromInt(0x40013800);
pub const USART2: *volatile USART_Peripheral = @ptrFromInt(0x40004400);
pub const USART4: *volatile USART_Peripheral = @ptrFromInt(0x40004C00);
pub const USART5: *volatile USART_Peripheral = @ptrFromInt(0x40005000);
pub const USB_FS: *volatile USB_FS_Peripheral = @ptrFromInt(0x40005C00);
pub const USB_SRAM: *volatile USB_SRAM_Peripheral = @ptrFromInt(0x40006000);
pub const WWDG: *volatile WWDG_Peripheral = @ptrFromInt(0x40002C00);

/// Interrupt requests
pub const IRQn = enum(u32) {
    /// Window Watchdog interrupt
    WWDG = 0,
    /// PVD through EXTI line detection
    PVD = 1,
    /// RTC global interrupt
    RTC = 2,
    /// RCC global interrupt
    RCC = 4,
    /// EXTI Line[1:0] interrupts
    EXTI0_1 = 5,
    /// EXTI Line[3:2] interrupts
    EXTI2_3 = 6,
    /// EXTI Line[3:2] interrupts
    EXTI2_3 = 6,
    /// EXTI Line15 and EXTI4 interrupts
    EXTI4_15 = 7,
    /// Touch sensing interrupt
    TSC = 8,
    /// DMA1 Channel1 global interrupt
    DMA1_Channel1 = 9,
    /// DMA1 Channel2 and 3 interrupts
    DMA1_Channel2_3 = 10,
    /// DMA1 Channel4 to 7 interrupts
    DMA1_Channel4_7 = 11,
    /// ADC and comparator 1 and 2
    ADC_COMP = 12,
    /// LPTIMER1 interrupt through EXTI29
    LPTIM1 = 13,
    /// USART4/USART5 global interrupt
    USART4_USART5 = 14,
    /// TIM2 global interrupt
    TIM2 = 15,
    /// TIM3 global interrupt
    TIM3 = 16,
    /// TIM6 global interrupt and DAC
    TIM6_DAC = 17,
    /// TIM7 global interrupt and DAC
    TIM7 = 18,
    /// TIMER21 global interrupt
    TIM21 = 20,
    /// I2C3 global interrupt
    I2C3 = 21,
    /// TIMER22 global interrupt
    TIM22 = 22,
    /// I2C1 global interrupt
    I2C1 = 23,
    /// I2C2 global interrupt
    I2C2 = 24,
    /// SPI1_global_interrupt
    SPI1 = 25,
    /// SPI2 global interrupt
    SPI2 = 26,
    /// USART1 global interrupt
    USART1 = 27,
    /// USART2 global interrupt
    USART2 = 28,
    /// AES global interrupt RNG global interrupt and LPUART1 global interrupt through
    AES_RNG_LPUART1 = 29,
    /// LCD global interrupt
    LCD = 30,
    /// USB event interrupt through EXTI18
    USB = 31,
};

pub const GPIO_Function = enum {
    none,
    comp1,
    comp2,
    eventout,
    i2c1,
    i2c2,
    i2c3,
    lpuart1,
    lptim1,
    mco,
    rtc,
    spi1,
    spi2,
    swd,
    tim2,
    tim3,
    tim21,
    tim22,
    tsc,
    usart1,
    usart2,
    usart4,
    usart5,
    usb,
};

pub const GPIO_FunctionTable = [_][16][8]GPIO_Function{
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
    //GPIOB
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
    //GPIOC
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
