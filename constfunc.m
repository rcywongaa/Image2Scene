function ret = constfunc(x)
    global NUM_LABELS;
    weights = vec2mat(x, NUM_LABELS);
    ret = sum(weights, 2) - ones(size(weights, 1), 1);
endfunction
