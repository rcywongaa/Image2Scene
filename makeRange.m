function range = makeRange(from, to)
    from = fixAngle(from);
    to = fixAngle(to);
    if (to < from)
        range = [1:to, from:360];
    else
        range = [from:to];
    end
endfunction

