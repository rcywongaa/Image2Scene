function edges = drawSector(middle, sector) %in degrees
    edges = zeros(4, 1);
    middle = middle * pi/180;
    angle = sector(1) * pi/180;
    offset = sector(2) * pi/180;
    angle2 = sector(3) * pi/180;
    start_deg = middle - angle/2;
    end_deg = start_deg + angle;
    edges(1:2, 1) = [start_deg; end_deg];
    if (end_deg < start_deg)
        t = [0:0.1:end_deg, start_deg:0.01:2*pi];
    else
        t = [start_deg:0.01:end_deg];
    end
    x = cos(t);
    y = sin(t);
    plot([0,x,0],[0,y,0], 'Color', [0, 0, 0])
    if offset != 0
        start_deg = middle + offset - angle2/2;
        end_deg = start_deg + angle2;
        edges(3:4, 1) = [start_deg, end_deg];
        if (end_deg < start_deg)
            t = [0:0.1:end_deg, start_deg:0.01:2*pi];
        else
            t = [start_deg:0.01:end_deg];
        end
        x = cos(t);
        y = sin(t);
        plot([0,x,0],[0,y,0], 'Color', [0, 0, 0])
    end
endfunction
