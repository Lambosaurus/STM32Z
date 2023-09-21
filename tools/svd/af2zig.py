import sys

class AFPin():
    def __init__(self, name: str, afs: list[str]):
        self.name = name
        self.afs = afs

    def write(self, file):
        file.write(f"        //{self.name}\n")

        items = ", ".join( self.decode_af(af) for af in self.afs )
        file.write("        .{ " + items + " },\n")

    def decode_af(self, af: str) -> str:
        if af in ['-', '']:
            return ".none"
        
        device = af.split('_')[0]

        if device in ["SWDIO", "SWCLK"]:
            return ".swd"

        return f".{device.lower()}"
        

class AFPort():
    def __init__(self, name: str):
        self.name = name
        self.pins: list[AFPin] = []

    def write(self, file):
        file.write(f"    //{self.name}\n")
        file.write("    .{\n")
        for pin in self.pins:
            pin.write(file)
        file.write("    },\n")

    def add_pin(self, pin: str, afs: list[str]):
        self.pins.append( AFPin(pin, afs) )

class AFContent():
    def __init__(self):
        self.ports: list[AFPort] = []

    def add_pin(self, pin: str, afs: list[str]):
        port, n = self.parse_pin(pin)

        if port >= len(self.ports):
            name = f"GPIO{ chr(ord('A') + port) }"
            self.ports.append( AFPort(name) )

        self.ports[port].add_pin(pin, afs)

    def parse_pin(self, pin: str) -> tuple[int, int]:
        port = ord(pin[1:2]) - ord('A')
        n = int(pin[2:])
        return port, n

    def write(self, file):
        file.write("pub const GPIO_FunctionTable = [_][2][8]GPIO_Function{\n")

        for port in self.ports:
            port.write(file)

        file.write("};\n")



def read_af(src) -> AFContent:
    content = AFContent()

    # Skip header
    src.readline()

    for row in src:
        cols = row.split(',')
        name = cols[0]
        afs = [s.strip() for s in cols[1:]]

        content.add_pin(name, afs)

    return content


def write_zig(dst, content: AFContent):
    content.write(dst)

if __name__ == "__main__":
    
    if len(sys.argv) < 3:
        print("src and dst file must be specified")
    
    src_path = sys.argv[1]
    dst_path = sys.argv[2]
    

    with open(src_path, 'r') as src:
        content = read_af(src)
    with open(dst_path, 'w') as dst:
        write_zig(dst, content)
            
