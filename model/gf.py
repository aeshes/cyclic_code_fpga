from bits import *

def gf_mul(a, b):
    assert a >= 0 and b >= 0
    result = 0

    while a != 0:
        if a & 1 == 1:
            result ^= b
        a = a >> 1
        b = b << 1

    return result

def gf_rem(a, b):
    assert b != 0
    assert a >= 0
    result = a

    while degree(result) >= degree(b):
        power = degree(result) - degree(b)
        result ^= b << power

    return result

def gf_quo(a, b):
    quo = 0
    rem = a

    while degree(rem) >= degree(b):
        power = degree(rem) - degree(b)
        rem ^= b << power
        quo ^= 1 << power

    return quo