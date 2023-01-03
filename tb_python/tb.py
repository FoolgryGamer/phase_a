import numpy as np

test_icon = 1
if test_icon == 0:
    ###################################
    #inner_loop test
    # a = np.random.choice(range(pow(2,3074)))
    a = 0x3237ad864c06090a9128f138679cd00809d7d606512d8316468408b7578973b7c9b5e06e453022fc2ae6f4d699e21e2c2df94a93b6719835041166c541336707bc323bafdeb3bfc765fc46a71f033115323fa508bc745e5a6a3c186ce69958ed660451225c7c59e6bcc33ca5ae25e729533fcf57b4daccc5cd8cd7357a4bb1be9334e8518989a7886edbf3563b62e307de757c19a9f42db11357c1e451d1815f27085280a8704d733991599ab8374666ab3588de82861f2bf30ea16d5e25d43dd3e00fb454cf9b1e6d7a8519880bc40c0e1ad46928fdd7c58236677b8905852b660fea0f22d4a2bbdd89d2cb3bd9ca2437c3eb0212107089441e52fc2d39ff8a7780a7ee0889a265182bdfeadb32caa172718c6daad93ca9147098950fde859b48b34b529ada03608035bf10f118f0eefdd7fb4284083dcde36afa3954cb7f7d57b6aa2f5c7072259173cb8d97218cc0b5209b8a40b24077bbc0bcc9af8f2d2de3b8dad8fc9c895f450eaa2740e6d0dfdab77dbe90cfb52f766d33b1c9b7c2ffc
    # b = np.random.choice(range(pow(2,54)))
    b = 0b110000_00110011_00101101_00110010_11010011_10000100_11101000_110000_00110011_00101101_00110010_11010011_10000100_11101000
    # b = hex(b)
    # print(b)
    print(hex(a*b))
elif test_icon == 1:
    ###################################
    #multiplier test  
    # radix = 54 
    a1 = 0x1be90cfb52f766_dbe90cfb52f766
    bi = 0b00110000_00110011_00101101_00110010_11010011_10000100_11101000_00110000_00110011_00101101_00110010_11010011_10000100_111010
    a11 =a1 & 0x1ffffff
    a12 =(a1 & 0x3fffffe000000) >> 25
    a13 =(a1 & 0x7fffffc000000000000) >> 50
    a14 =(a1 & 0xffffff8000000000000000000) >> 75
    a15 =a1 >> 100
    b1 = bi & 0xffff
    b2 =(bi & 0xffffffff) >> 16
    b3 =(bi & 0xffffffffffff) >> 32
    b4 =(bi & 0xffffffffffffffff) >> 48
    b5 =(bi & 0xffffffffffffffffffff) >> 64
    b6 =(bi & 0xffffffffffffffffffffffff) >> 80
    b7 = bi >> 96
    print("***************")
    print(hex(a11))
    print(hex(a12))
    print(hex(a13))
    print(hex(a14))
    print(hex(a15))
    print(hex(b1))
    print(hex(b2))
    print(hex(b3))
    print(hex(b4))
    print(hex(b5))
    print(hex(b6))
    print(hex(b7))
    print("***************")
    print(hex(a11*b1))
    print(hex(a11*b2))
    print(hex(a11*b3))
    print(hex(a11*b4))
    print(hex(a11*b5))
    print(hex(a11*b6))
    print(hex(a11*b7))
    print(hex(a12*b1))
    print(hex(a12*b2))
    print(hex(a12*b3))
    print(hex(a12*b4))
    print(hex(a12*b5))
    print(hex(a12*b6))
    print(hex(a12*b7))
    print(hex(a13*b1))
    print(hex(a13*b2))
    print(hex(a13*b3))
    print(hex(a13*b4))
    print(hex(a13*b5))
    print(hex(a13*b6))
    print(hex(a13*b7))
    print(hex(a14*b1))
    print(hex(a14*b2))
    print(hex(a14*b3))
    print(hex(a14*b4))
    print(hex(a14*b5))
    print(hex(a14*b6))
    print(hex(a14*b7))
    print(hex(a15*b1))
    print(hex(a15*b2))
    print(hex(a15*b3))
    print(hex(a15*b4))
    print(hex(a15*b5))
    print(hex(a15*b6))
    print(hex(a15*b7))
    print("***************")
    print(hex(a1*bi))
    print("***************")
    print(hex(bi))
    print(hex(a1))
    print(hex((a1*bi)>>218))
    print(hex((a1*bi) >> 108))
    print(hex(((a1*bi)>>216)<<108))