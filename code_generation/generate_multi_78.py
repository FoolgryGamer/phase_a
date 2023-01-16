print_part = 3
b_part = 4
if print_part == 0:
    for i in range(7):
        for j in range(5):
            print("out[{}] <= 0;".format(i*5+j),end = "")
        print("")

elif print_part == 1:
    b_part = 4
    for i in range (4):
        for j in range(4):
            print("assign wire_out[{}] = ".format(i*b_part+j),end = "")
            a_gap = 20 # 25 * 5 = 125
            b_gap = 20 # 16 * 7 = 112
            front_size = 160 - 40 - i*a_gap - j*b_gap
            end_size = i*a_gap + j*b_gap
            if(front_size == 0): 
                print("{"+"out[{}],{}'b0".format(i*b_part+j,end_size)+ "};")
            elif(end_size == 0):
                print("{"+"{}'b0,out[{}]".format(front_size,i*b_part+j)+ "};")
            else:
                print("{"+"{}'b0,out[{}],{}'b0".format(front_size,i*b_part+j,end_size)+ "};")

elif print_part == 2:
    for i in range(4):
        for j in range(4):
            print("out[{}] <= wire_a[{}]*wire_b[{}];".format(i*b_part+j,i,j))

elif print_part == 3:
    for i in range(4):
        print("tmp[{}] <= ".format(i),end = "")
        for j in range(4):
            if j != 3:
                print("wire_out[{}] + ".format(i*4+j),end = "")
            else:
                print("wire_out[{}];".format(i*4+j))