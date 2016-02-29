%This function is fake
%Output: List of objects {(2D coordinates) + label + color}
function obj = segmentImage(file_name)
    %Label index
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
    NUM_LABELS = FRONT_WALL;
    %Lengths in m
    global ROOM_LENGTH = 5;
    global ROOM_WIDTH = 5;
    PILLOW_LENGTH = 0.5;
    PILLOW_WIDTH = 0.5;
    BED_LENGTH = 2;
    BED_WIDTH = 1.5;
    BLANKET_LENGTH = 1.5;
    MAT_LENGTH = 2;
    MAT_WIDTH = 2;
    TABLE_WIDTH = 1;
    TABLE_LENGTH = 0.5;
    SOFA_WIDTH = 1;
    SOFA_LENGTH = 1;
    %Region index
    BACK = 1;
    LEFT = 2;
    RIGHT = 3;
    FRONT = 4;
    CENTER = 5;
    %Element index
    global COL_H = 1;
    global COL_S = 2;
    global COL_V = 3;
    global COORD_X = 4; %Lower left corner
    global COORD_Y = 5; %Lower left corner
    global WIDTH = 6;
    global LENGTH = 7;
    global REGION = 8;
    global PAIR = 9;
    global NUM_ELEMENTS = 9;

    if strcmp(file_name, 'analog_bedroom.jpg')
        obj = zeros(NUM_LABELS, NUM_ELEMENTS);
        obj(PILLOW1,:) = [215/360, 0.878, 0.384, 0.5*ROOM_WIDTH-PILLOW_WIDTH, ROOM_LENGTH-1.3*PILLOW_LENGTH, PILLOW_WIDTH, PILLOW_LENGTH, CENTER, BEDFRAME];
        obj(PILLOW2,:) = [187/360, 0.798, 0.427, 0.5*ROOM_WIDTH, ROOM_LENGTH-1.3*PILLOW_LENGTH, PILLOW_WIDTH, PILLOW_LENGTH, CENTER, BEDFRAME];
        obj(PILLOW3,:) = [207/360, 0.126, 0.902, 0.5*ROOM_WIDTH-0.5*PILLOW_WIDTH, ROOM_LENGTH-2*PILLOW_LENGTH, PILLOW_WIDTH, PILLOW_LENGTH, CENTER, BEDFRAME];
        obj(PILLOW4,:) = [215/360, 0.935, 0.243, 0.5*ROOM_WIDTH - 0.5*PILLOW_WIDTH, ROOM_LENGTH-3*PILLOW_LENGTH, PILLOW_WIDTH, PILLOW_LENGTH, CENTER, BEDFRAME];
        obj(MATTRESS,:) = [0, 0, 1, 0.5*ROOM_WIDTH-0.5*BED_WIDTH, ROOM_LENGTH-BED_LENGTH, BED_WIDTH, BED_LENGTH, CENTER, BEDFRAME];
        obj(BLANKET,:) = [186/360, 0.832, 0.514, 0.5*ROOM_WIDTH-0.5*BED_WIDTH, ROOM_LENGTH-BED_LENGTH, BED_WIDTH, BLANKET_LENGTH, CENTER, BEDFRAME];
        obj(BEDFRAME,:) = [0, 0, 1, 0.5*ROOM_WIDTH-0.5*BED_WIDTH, ROOM_LENGTH-BED_LENGTH, BED_WIDTH, BED_LENGTH, BACK, BEDFRAME];
        obj(MAT,:) = [138/360, 0.07, 0.725, 0.5*ROOM_WIDTH-0.5*MAT_WIDTH, 0.5*ROOM_LENGTH-0.5*MAT_LENGTH, MAT_WIDTH, MAT_LENGTH, CENTER, NA];
        obj(TABLE_R,:) = [0, 0, 1, 0.5*ROOM_WIDTH+0.5*BED_WIDTH + 0.1, ROOM_LENGTH-TABLE_LENGTH, TABLE_WIDTH, TABLE_LENGTH, BACK, BEDFRAME];
        obj(TABLE_L,:) = [0, 0, 1, 0.5*ROOM_WIDTH-0.5*BED_WIDTH - 0.1 - TABLE_WIDTH, ROOM_LENGTH-TABLE_LENGTH, TABLE_WIDTH, TABLE_LENGTH, BACK, BEDFRAME];
        obj(SOFA,:) = [99/360, 0.113, 0.592, ROOM_WIDTH-SOFA_WIDTH, 1, SOFA_WIDTH, SOFA_LENGTH, RIGHT, NA];
        obj(FLOOR,:)= [166/360, 0.141, 0.694, 0, 0, ROOM_WIDTH, ROOM_LENGTH, CENTER, NA];
        obj(BACK_WALL,:) = [183/360, 0.925, 0.471, 0, ROOM_LENGTH, ROOM_WIDTH, 0.05, BACK, NA];
        obj(LEFT_WALL,:) = [0, 0, 1, 0, 0, 0.05, ROOM_LENGTH, LEFT, NA];
        obj(RIGHT_WALL,:) = [0, 0, 1, ROOM_WIDTH, 0, 0.05, ROOM_LENGTH, RIGHT, NA];
        obj(FRONT_WALL,:) = [0, 0, 1, 0, 0, ROOM_WIDTH, 0.05, FRONT, NA];

        %Draw layout
        order = [FLOOR, MAT, SOFA, TABLE_R, TABLE_L, BEDFRAME, MATTRESS, BLANKET, PILLOW2, PILLOW1, PILLOW4, PILLOW3, BACK_WALL, LEFT_WALL, RIGHT_WALL, FRONT_WALL];
        figure
        drawScene(obj, order);
    end
endfunction
