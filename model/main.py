from ecc import *

def main():
    plain = 0x0A
    encoded = encode(plain)
    decoded = decode(encoded)
    errored = 0b1110011
    corrected = decode(errored)
    print(bin(encoded))
    print(bin(decoded))
    print(bin(corrected))

if __name__ == '__main__':
    main()