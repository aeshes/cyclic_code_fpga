from gf import *

# Порождающий многочлен x^3 + x + 1 = (1011)
g = 0x0B

def encode(u):
    # Систематическое кодирование выполняется по формуле:
    # c(x) = x^(n-k) * i(x) + t(x), где t(x) = x^(n-k) * i(x) mod g(x)
    return rol(u, 3) ^ gf_rem(rol(u, 3), g)

# Синдром это, в сущности, линейное преобразование вектора ошибки
# Сопоставим каждому синдрому сооответствующий вектор ошибки
syndrome_to_error = {
    0x01 : 0x01,
    0x02 : 0x02,
    0x04 : 0x04,
    0x03 : 0x08,
    0x06 : 0x10,
    0x07 : 0x20,
    0x05 : 0x40
}

def decode(v):
    syndrome = gf_rem(v, g)

    if syndrome != 0:
        v = v ^ syndrome_to_error[syndrome]

    return v >> 3

code_length = 7
code_bitmask = 0x7F

def rol(a, bits):
    return ((a << bits) | (a >> (code_length - bits))) & code_bitmask