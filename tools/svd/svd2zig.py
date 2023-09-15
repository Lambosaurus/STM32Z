import xml.sax as xml
import sys


class CPU():
    def __init__(self):
        self.name: str = None
        self.endian: str = None
        self.mpu_present: str = False
        self.fpu_present: bool = False
        self.nvic_prio_bits: int = None

    def write(self, dst):
        # /// CPU Information
        # pub const CPU = struct {
        #     pub const core = "CM0+";
        #     pub const endian = "little";
        #     pub const mpu_present = false;
        #     pub const fpu_present = false;
        #     pub const nvic_prio_bits = 3;
        # };

        dst.write("/// CPU Information\n")
        dst.write("pub const CPU = struct {\n")
        dst.write(f"    pub const core = \"{self.name}\";\n")
        dst.write(f"    pub const endian = \"{self.endian};\";\n")
        dst.write(f"    pub const mpu_present = {self._to_zig_bool(self.mpu_present)};\n")
        dst.write(f"    pub const fpu_present = {self._to_zig_bool(self.fpu_present)};\n")
        dst.write(f"    pub const nvic_prio_bits = {self.nvic_prio_bits};\n")
        dst.write("};\n")

    def _to_zig_bool(self, value: bool) -> str:
        return "true" if value else "false"

class Peripheral():
    def __init__(self):
        self.name: str = None
        self.base_address: int = None
        self.group_name: str = None
        self.registers: list[Register] = []
        self.description: str = "NO DESCRIPTION"
        self.derived_from: str = None
        self.struct_name: str = None
        self.use_r32: bool = False

    def process(self, use_r32: bool = False):
        self.use_r32 = use_r32

        # Ideally the presence of registers would mirror derived structs.
        self.name = self.name.upper()

        if len(self.registers):
            # Ensure the registers are in address order
            self._clean_register_names()
            self.registers.sort( key = lambda r: r.address_offset )
            self._join_io_fields()

        for r in self.registers:
            r.process(use_r32)

        # currently just discarding the SVD derived_from
        self.derived_from = self._get_derived_name()
        self.struct_name = f"{self.derived_from}_Peripheral"
            
    def _get_derived_name(self):
        if self.name.startswith("GPIO"):
            # "GPIOA" -> "GPIO"
            return "GPIO"
        
        for i in range(len(self.name)-1, 0, -1):
            # "TIM22" -> "TIM"
            # "I2C2" ->  "I2C"
            # "ADC" -> "ADC"
            if self.name[i].isalpha():
                return self.name[:i+1]
        
        return self.name

    def write_struct(self, dst):

        # /// General-purpose I/Os
        # pub const GPIOA_Peripheral = struct {
        # ...
        # };

        # Write the peripheral struct header
        dst.write(f"/// {self.description}\n")
        dst.write(f"pub const {self.struct_name} = packed struct {'{'}\n")

        last_offset = 0
        # Write out each register
        for r in self.registers:

            # If there are gaps, pad them with unused bits.
            if r.address_offset > last_offset:
                size = r.address_offset - last_offset
                if (size == 4):
                    dst.write(f"    _unused{last_offset}: u32,\n")
                else:
                    dst.write(f"    _unused{last_offset}: [{size}]u8,\n")
            elif r.address_offset < last_offset:
                raise Exception("Register address overlap")

            if r.bit_size % 8 != 0:
                raise Exception("Register not byte aligned")
            last_offset = r.address_offset + (r.bit_size // 8)

            r.write(dst)

        # End peripheral struct
        dst.write("};\n")

    def write_instance(self, dst):
        # var GPIOA: *volatile GPIOA_Peripheral = @ptrFromInt(0x50000000);
        dst.write(f"pub const {self.name}: *volatile {self.struct_name} = @ptrFromInt(0x{self.base_address:08X});\n")

    def _join_io_fields(self):
        # "CCMR1_Output" & "CCMR1_Input" -> "CCMR1"

        i = 0
        while i < len(self.registers) - 1:
            reg_a = self.registers[i]
            reg_b = self.registers[i+1]
            if reg_a.address_offset == reg_b.address_offset:

                # we have duplicate registers.
                if reg_b.name.endswith("_Output"):
                    selected_reg = reg_b
                else:
                    selected_reg = reg_a
                
                # keep our favourite register
                self.registers[i] = selected_reg
                # remove the second item
                self.registers.pop(i+1)

                if selected_reg.name.endswith("_Output"):
                    selected_reg.name = selected_reg.name.removesuffix("_Output")

            i += 1

    def _clean_register_names(self):
        # "MPU_TYPER" -> "TYPER"

        name_prefix = f"{self.name}_"
        for r in self.registers:
            r.name = r.name.removeprefix(name_prefix)


class Interrupt():
    def __init__(self):
        self.name: str = None
        self.description: str = "NO DESCRIPTION"
        self.value: int = None

    def write(self, dst):
        dst.write(f"    /// {self.description}\n")
        dst.write(f"    {self.name} = {self.value},\n")


class Register():
    def __init__(self):
        self.name: str = None
        self.address_offset: int = None
        self.bit_size: int = None
        self.fields: list[Field] = []
        self.description: str = "NO DESCRIPTION"
        self.use_r32: bool = False

    def process(self, use_r32: bool = False):
        self.use_r32 = use_r32

    def write(self, dst):
        # Ensure the fields are in bit order
        self.fields.sort( key = lambda f: f.bit_offset )

        dst.write(f"    /// [+0x{self.address_offset:02X}] {self.description}\n")

        # Single field condition
        if len(self.fields) == 1 and self.fields[0].bit_size == self.bit_size:
            self._write_as_word(dst)
        else:
            self._write_as_struct(dst)

    def _write_as_struct(self, dst):
        # /// [+0x00] GPIO port mode register
        # MODER: packed struct {
        # ...
        # };
        
        if self.use_r32:
            dst.write(f"    {self.name}: r32(packed struct {'{'}\n")
        else:
            dst.write(f"    {self.name}: packed struct {'{'}\n")

        # Write all the fields out
        last_bit = 0
        for f in self.fields:

            # If there are gaps, pad them with unused bits.
            if f.bit_offset > last_bit:
                size = f.bit_offset - last_bit
                dst.write(f"        _unused{last_bit}: u{size} = 0,\n")
            elif f.bit_offset < last_bit:
                raise Exception("Field address overlap")
            last_bit = f.bit_offset + f.bit_size
                
            f.write(dst)
            

        # Write unused fields to pad out to the register size
        if last_bit < self.bit_size:
            size = self.bit_size - last_bit
            dst.write(f"        _unused{last_bit}: u{size} = 0,\n")

        # End register
        
        if self.use_r32:
            dst.write("    }),\n")
        else:
            dst.write("    },\n")

    def _write_as_word(self, dst):
        # /// [+0x00] GPIO port mode register
        # MODER: u32,
        dst.write(f"    {self.name}: u{self.bit_size},\n")
        

class Field():
    def __init__(self):
        self.name: str = None
        self.bit_offset: int = None
        self.bit_size: int = None
        self.description: str = "NO DESCRIPTION"

    def write(self, dst):
        # /// [0:2] Port x configuration bits (y = 0..15)
        # MODE0: u2,
        bit_stop = self.bit_offset + self.bit_size
        dst.write(f"        /// [{self.bit_offset}:{bit_stop}] {self.description}\n")
        dst.write(f"        {self.name}: u{self.bit_size} = 0,\n")


R32_CODE = '''\
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
    };
}
'''

class SVDContent():
    def __init__(self):
        self.peripherals: list[Peripheral] = []
        self.interrupts: list[Interrupt] = []
        self.structs: list[Peripheral] = []
        self.cpu: CPU = None
        self.name: str = None
        self.use_r32: bool = False

    def process(self, use_r32: bool = False):
        self.use_r32 = use_r32

        # Sort the peripherals by name
        self.peripherals.sort( key= lambda p: p.name )

        for p in self.peripherals:
            p.process(self.use_r32)

        # First alphabetic struct wins
        # TIM2 has more registers than TIM22.
        for p in self.peripherals:
            if not self._is_struct_defined(p.struct_name):
                self.structs.append(p)

        self.interrupts.sort( key= lambda i: i.value )

    def _is_struct_defined(self, name: str):
        for p in self.structs:
            if p.struct_name == name:
                return True
        return False

    def write(self, dst):

        dst.write("//! Register and peripheral definitions for the STM32L0x3\n")
        dst.write("//! This file has been generated from the supplied svd file\n")
        dst.write("//! If there are any corrections needed, please edit the svd3zig generator tools\n")
        dst.write("\n")

        if self.use_r32:
            dst.write(R32_CODE)
            dst.write("\n")

        dst.write(f"pub const part_name = \"{self.name}\";\n")
        dst.write("\n")

        self.cpu.write(dst)
        dst.write("\n")

        for p in self.structs:
            p.write_struct(dst)
            dst.write("\n")

        for p in self.peripherals:
            p.write_instance(dst)
        dst.write("\n")

        self._write_interrupts(dst)
        dst.write("\n")

    def _write_interrupts(self, dst):
        # /// Interrupt requests
        # pub const IRQn = enum(u32) {
        # ...
        # };
        dst.write("/// Interrupt requests\n")
        dst.write("pub const IRQn = enum(u32) {\n")

        for intr in self.interrupts:
            intr.write(dst)

        dst.write("};\n")

    def _lookup_peripheral(self, name: str) -> str:
        for p in self.peripherals:
            if p.name == name:
                return p


class SVDHandler(xml.ContentHandler):
    def __init__(self):
        self.svd = SVDContent()

        self.peripheral: Peripheral = None
        self.register: Register = None
        self.field: Field = None
        self.interrupt: Interrupt = None
        self.cpu: CPU = None

        self.tag: str = None
        self.tag_content: str = None
    
    # Callbacks from XML SAX handler
    def startElement(self, tag: str, attributes):
        
        if tag == "cpu":
            self.cpu = CPU()

        elif tag == "peripheral":
            self.peripheral = Peripheral()
            if "derivedFrom" in attributes:
                self.peripheral.derived_from = attributes["derivedFrom"]
        
        elif tag == "register":
            self.register = Register()

        elif tag == "field":
            self.field = Field()

        elif tag == "interrupt":
            self.interrupt = Interrupt()

        self.tag = tag
        self.tag_content = ""

    # Callbacks from XML SAX handler
    def endElement(self, tag: str):
        
        if tag == "cpu":
            self.svd.cpu = self.cpu
            self.cpu = None

        elif tag == "peripheral":
            self.svd.peripherals.append(self.peripheral)
            self.peripheral = None

        elif tag == "register":
            self.peripheral.registers.append(self.register)
            self.register = None
            
        elif tag == "field":
            self.register.fields.append(self.field)
            self.field = None

        elif tag == "interrupt":
            self.svd.interrupts.append(self.interrupt)
            self.interrupt = None

        elif len(self.tag_content):
            self._submit_property(self.tag, self.tag_content)
            self.tag = None
            
    def _submit_property(self, tag: str, content: str):
        if self.interrupt:
            if tag == "name":
                self.interrupt.name = content
            elif tag == "description":
                self.interrupt.description = self._clean_description(content)
            elif tag == "value":
                self.interrupt.value = self._parse_int(content)
        elif self.field:
            if tag == "name":
                self.field.name = content
            elif tag == "description":
                self.field.description = self._clean_description(content)
            elif tag == "bitOffset":
                self.field.bit_offset = self._parse_int(content)
            elif tag == "bitWidth":
                self.field.bit_size = self._parse_int(content)
        elif self.register:
            if tag == "name":
                self.register.name = content
            elif tag == "description":
                self.register.description = self._clean_description(content)
            elif tag == "addressOffset":
                self.register.address_offset = self._parse_int(content)
            elif tag == "size":
                self.register.bit_size = self._parse_int(content)
        elif self.peripheral:
            if tag == "name":
                self.peripheral.name = content
            elif tag == "description":
                self.peripheral.description = self._clean_description(content)
            elif tag == "groupName":
                self.peripheral.group_name = content
            elif tag == "baseAddress":
                self.peripheral.base_address = self._parse_int(content)
        elif self.cpu:
            if tag == "name":
                self.cpu.name = content
            elif tag == "endian":
                self.cpu.endian = content
            elif tag == "mpuPresent":
                self.cpu.mpu_present = self._parse_bool(content)
            elif tag == "fpuPresent":
                self.cpu.fpu_present = self._parse_bool(content)
            elif tag == "nvicPrioBits":
                self.cpu.nvic_prio_bits = self._parse_int(content)
        else:
            if tag == "name":
                self.svd.name = content

    def _parse_bool(self, content: str) -> bool:
        return content == "true"

    def _parse_int(self, content: str) -> int:
        if content.startswith("0x"):
            return int(content, 16)
        return int(content)
    
    def _clean_description(self, content: str) -> str:
        return " ".join( c.strip() for c in content.split("\n") )
        
    # Callbacks from XML SAX handler
    def characters(self, content: str):
        self.tag_content += content

    def get_svd(self) -> SVDContent:
        self.svd.process(True)
        return self.svd


def read_svd(src) -> SVDContent:
    svd = SVDHandler()
    parser = xml.make_parser()
    parser.setContentHandler(svd)
    parser.parse(src)
    return svd.get_svd()


def write_zig(dst, content: SVDContent):
    content.write(dst)

if __name__ == "__main__":
    
    if len(sys.argv) < 3:
        print("src and dst file must be specified")
    
    src_path = sys.argv[1]
    dst_path = sys.argv[2]
    
    #src_path = "../svd/STM32L0x4.svd"
    #dst_path = "out.zig"

    with open(src_path, 'r') as src:
        content = read_svd(src)
    with open(dst_path, 'w') as dst:
        write_zig(dst, content)
            
