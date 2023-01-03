print_part =3

if print_part == 0:
    for i in range(4):
        print("wire [44:0] ",end = "")
        for j in range(6):
            print("multi_res_{}[blocks-1:0]".format(i*6+j),end = "")
            if j != 5:
                print(",",end = "")
        print(";")

elif print_part == 1:
    for i in range(4):
        print("reg [44:0] ",end = "")
        for j in range(6):
            print("add1_a_{}[blocks-1:0]".format(i*6+j),end = "")
            if j != 5:
                print(",",end = "")
        print(";")

elif print_part == 2:
    print("wire [radix*2-1:0] ",end ="")
    for i in range(8):
        print("add1_res_{}".format(i),end= "")
        if i == 7:
            print(";")
        else:
            print(",",end = "")
        
elif print_part == 3:
    print("reg [radix*2-1:0] ",end = "")
    for i in range(8):
        print("add2_a_{}".format(i),end= "")
        if i == 7:
            print(";")
        else:
            print(",",end = "")
        