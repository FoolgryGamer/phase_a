for i in range(4):
    b_part = 5
    for j in range(6):
        print("assign res_{} = wire_a[{}]*wire_b[{}];".format(i*b_part+j,i,j))