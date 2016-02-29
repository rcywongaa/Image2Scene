function drawScene(obj, order, width, length)
    PILLOW1 = 1;
    PILLOW2 = PILLOW1+1;
    PILLOW3 = PILLOW2+1;
    PILLOW4 = PILLOW3+1;
    MATTRESS = PILLOW4+1;
    BLANKET = MATTRESS+1;
    BEDFRAME = BLANKET+1;
    MAT = BEDFRAME+1;
    TABLE_R = MAT+1;
    TABLE_L = TABLE_R+1;
    SOFA = TABLE_L+1;
    FLOOR = SOFA+1;
    BACK_WALL = FLOOR+1;
    LEFT_WALL = BACK_WALL+1;
    RIGHT_WALL = LEFT_WALL+1;
    FRONT_WALL = RIGHT_WALL+1;
    COFFEE_TABLE = FRONT_WALL+1;
    VASE = COFFEE_TABLE+1;
    DESK = VASE+1;
    CHAIR = DESK+1;
    CUPBOARD = CHAIR+1;
    NUM_LABELS = CUPBOARD; 
    global COL_H;
    global COL_S;
    global COL_V;
    global COORD_X;
    global COORD_Y;
    global WIDTH;
    global LENGTH;
    global ROOM_LENGTH;
    global ROOM_WIDTH;
    rectangle('Position', [0 0 ROOM_WIDTH ROOM_LENGTH], 'EdgeColor', 'None');
    axis([0 ROOM_WIDTH+0.5 0 ROOM_LENGTH+0.5]);
    if !exist('order')
        order = [FLOOR, COFFEE_TABLE, DESK, CHAIR, VASE, CUPBOARD, BEDFRAME, MATTRESS, BLANKET, PILLOW1, BACK_WALL, LEFT_WALL, RIGHT_WALL, FRONT_WALL];
    end
    for i = 1:length(order)
        rectangle('Position', [obj(order(i), COORD_X:COORD_Y), obj(order(i), WIDTH:LENGTH)], 'FaceColor', hsv2rgb(obj(order(i), COL_H:COL_V)), 'EdgeColor', 'None');
    end
endfunction
