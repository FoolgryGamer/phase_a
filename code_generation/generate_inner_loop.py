print_part = 6

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
elif print_part == 4:
    for i in range(24):
        # print("add1_a_{}[p] <= 0;".format(i))
        print("add1_a_{}[p] <= multi_res_{}[p];".format(i,i))

elif print_part == 5:
    for i in range(24):
        if i == 23:
            print("multi_res_{}[i]".format(i),end = "")
        else:
            print("multi_res_{}[i],".format(i),end = "")

elif print_part == 6:
    for i in range(24):
        print("add1_a_{}[i],".format(i),end = "")
    for i in range(5):
        print("add1_res_{}[i],".format(i),end = "")