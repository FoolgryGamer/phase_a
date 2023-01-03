print_part = 3

if print_part == 0:
    for i in range(7):
        for j in range(5):
            print("out[{}] <= 0;".format(i*5+j),end = "")
        print("")

elif print_part == 1:
    for i in range (5):
        for j in range(7):
            print("assign wire_out[{}] = ".format(i*7+j),end = "")
            a_gap = 25 # 25 * 5 = 125
            b_gap = 16 # 16 * 7 = 112
            front_size = 220 - 41 - i*a_gap - j*b_gap
            end_size = i*a_gap + j*b_gap
            if(front_size == 0): 
                print("{"+"out[{}],{}'b0".format(i*7+j,end_size)+ "};")
            elif(end_size == 0):
                print("{"+"{}'b0,out[{}]".format(front_size,i*7+j)+ "};")
            else:
                print("{"+"{}'b0,out[{}],{}'b0".format(front_size,i*7+j,end_size)+ "};")

elif print_part == 2:
    for i in range(5):
        for j in range(7):
            print("out[{}] <= wire_a[{}]*wire_b[{}];".format(i*7+j,i,j))

elif print_part == 3:
    for i in range(6):
        print("tmp[{}] <= ".format(i),end = "")
        for j in range(6):
            if j != 5:
                print("wire_out[{}] + ".format(i*6+j),end = "")
            else:
                print("wire_out[{}];".format(i*6+j))