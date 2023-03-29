def bitlen(a):
    length = 0
    while a != 0:
        length = length + 1
        a = a >> 1
    return length

def degree(a):
    if a == 0:
        return -1
    else:
        return bitlen(a) - 1
    
def hamming_norm(a):
    result = 0
    while a != 0:
        if a & 1 == 1:
            result = result + 1
        a >>= 1
    return result

def hamming_distance(a, b):
    return hamming_norm(a ^ b)