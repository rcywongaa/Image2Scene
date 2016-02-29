function [cost, d] = costfunc(x)
    global ref_obj;
    global NUM_LABELS;
    weights = vec2mat(x, NUM_LABELS);
    cost = calcCorrCost(ref_obj, weights);
    if (nargout > 1)
        d = dCorrCost(ref_obj, weights)(:);
    end
endfunction
