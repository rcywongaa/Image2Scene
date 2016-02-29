function cost = calcCorrCost(obj, hue_weights)
    % i*j matrices
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
    cost = 0;
    hues = obj(:, COL_H);
    for i = 1 : size(obj, 1)
        summation = 0;
        for j = 1 : size(obj, 1)
            if (obj(i, REGION) == obj(j, REGION) || obj(i, PAIR) == obj(j, PAIR)) && (i != j)
                summation += hue_weights(i, j) * hues(j);
            end
        end
        cost += (hues(i) - summation)^2;
    end
    %keyboard
endfunction
