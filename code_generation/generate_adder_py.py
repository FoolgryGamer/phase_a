
print_part = 1
#	wire [radix*2-1:0] a_23_w = {a_23,171'b0}
if print_part == 0:
    for i in range (4):
        for j in range(6):
            print("wire [radix*2-1:0] a_{}_w = ".format(i*6+j,i*6+j),end = "")
            a_gap = 27
            b_gap = 18
            front_size = 216 - 45 - i*a_gap - j*b_gap
            end_size = i*a_gap + j*b_gap
            if(front_size == 0): 
                print("{"+"a_{},{}'b0".format(i*6+j,end_size)+ "};")
            elif(end_size == 0):
                print("{"+"{}'b0,a_{}".format(front_size,i*6+j)+ "};")
            else:
                print("{"+"{}'b0,a_{},{}'b0".format(front_size,i*6+j,end_size)+ "};")
        
# add2_adder_3 add2_0(a_0_w,a_1_w,a_2_w,res_0);
elif print_part == 1:
    for i in range (5):
        if i == 4:
            print("add2_adder_5#(.adder_size(radix*2)) add2_{}(a_{}_w,a_{}_w,a_{}_w,a_{}_w,216'b0,res_{});".format(i,i*5,i*5+1,i*5+2,i*5+3,i))
        else:
            print("add2_adder_5#(.adder_size(radix*2)) add2_{}(a_{}_w,a_{}_w,a_{}_w,a_{}_w,a_{}_w,res_{});".format(i,i*5,i*5+1,i*5+2,i*5+3,i*5+4,i))
       