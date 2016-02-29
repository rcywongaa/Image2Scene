function derivative = dCorrCost(obj, weights)
    global COL_H;
    global COL_S;
    global COL_V;
    global COORD_X;
    global COORD_Y;
    global WIDTH;
    global LENGTH;
    global REGION;
    global PAIR;
    global NUM_ELEMENTS;
    global NUM_LABELS;
    sum_of_neighbors = zeros(NUM_LABELS, 1);
    derivative = zeros(NUM_LABELS);
    hues = obj(:, COL_H);
    for i = 1 : size(obj, 1)
        for j = 1 : size(obj, 1)
            if (obj(i, REGION) == obj(j, REGION) || obj(i, PAIR) == obj(j, PAIR)) && (i != j)
                sum_of_neighbors(i) += weights(i, j) * hues(j);
            end
        end
    end
    for i = 1 : size(obj, 1)
        for j = 1 : size(obj, 1)
            if (obj(i, REGION) == obj(j, REGION) || obj(i, PAIR) == obj(j, PAIR)) && (i != j)
                derivative(i, j) = 2*(hues(i) - sum_of_neighbors(i))*(-hues(j));
            end
        end
    end
    %derivative
    %keyboard
endfunction
