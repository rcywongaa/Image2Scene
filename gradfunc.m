function d = gradfunc(x)
    global ref_obj;
    global NUM_LABELS;
    weights = vec2mat(x, NUM_LABELS);
    d = dCorrCost(ref_obj, weights)(:);
endfunction
