function new_score = addScoreMap(score_map, deg, score)
    global NUM_TYPES;
    global SECTOR;
    for type = 1:NUM_TYPES
        score_map(type, makeRange(deg - SECTOR(type, 1)/2, deg + SECTOR(type, 1)/2)) += score;
        if SECTOR(type, 2) != 0
            if 0
                score
                SECTOR(type, 2)
                SECTOR(type, 3)/2
                deg + SECTOR(type, 2) - SECTOR(type, 3)/2
                deg + SECTOR(type, 2) + SECTOR(type, 3)/2
                makeRange(deg - SECTOR(type, 2) - SECTOR(type, 3)/2, deg - SECTOR(type, 2) + SECTOR(type, 3)/2)
            end
            score_map(type, makeRange(deg - SECTOR(type, 2) - SECTOR(type, 3)/2, deg - SECTOR(type, 2) + SECTOR(type, 3)/2)) += score;
        end
        new_score = score_map;
    end
    %[deg, score_map(7, 45)]
endfunction
