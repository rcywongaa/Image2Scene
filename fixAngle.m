function ret = fixAngle(angle)
    ret = round(mod(angle, 360));
    if ret < 1
        ret = ret + 360;
    end
endfunction
