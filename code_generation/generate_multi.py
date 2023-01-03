for i in range(4):
    for j in range(6):
        print("assign res_{} = wire_a[{}]*wire_b[{}];".format(i*6+j,i,j))