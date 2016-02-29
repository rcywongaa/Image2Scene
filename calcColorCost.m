function cost = calcColorCost(scene_obj, ref_obj, hue_edges, corr_weights)
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
    %Non-existant objects characterized by 0 attributes
    ref_labels = find(max(ref_obj, [], 2));
    scene_labels = find(max(scene_obj, [], 2));
    matching_labels = intersect(scene_labels, ref_labels);
    E1 = 0;
    E2 = 0;
    E3 = 0;
    E4 = 0;

    for index = 1:size(matching_labels)
        label = matching_labels(index);
        E1 += (nangdiff(scene_obj(label, COL_H), ref_obj(label, COL_H)))^2;

        summation = 0;
        for j = 1 : size(matching_labels)
            label2 = matching_labels(j);
            if (scene_obj(label, REGION) == scene_obj(label2, REGION) || scene_obj(label, PAIR) == scene_obj(label2, PAIR)) && (label != label2)
                summation += corr_weights(label, label2) * scene_obj(label2, COL_H);
            end
        end
        E2 += (scene_obj(label, COL_H) - summation)^2;
    end

    K = 4;
    non_match_labels = setxor(scene_labels, matching_labels);
    for index = 1:size(non_match_labels)
        label = non_match_labels(index);
        [neighbors distances] = kNearestNeighbors(scene_obj(:, COORD_X:COORD_Y), scene_obj(label, COORD_X:COORD_Y), K+1);
        neighbors = neighbors(2:end);
        scene_obj(neighbors, COL_H);
        dominant_hue = mean(scene_obj(neighbors, COL_H));
        E3 += (nangdiff(scene_obj(label, COL_H), dominant_hue))^2;
    end

    for index = 1:size(scene_labels)
        label = scene_labels(index);
        hue = mod(scene_obj(label, COL_H), 1)*2*pi;
        %if (hue_edges(1) < hue_edges(2) && (hue < hue_edges(1) || hue > hue_edges(2))) || ...
                %(hue_edges(2) < hue_edges(1) && (hue < hue_edges(1) && hue > hue_edges(2)))
        if !(sign(angdiff(hue_edges(1), hue)) == sign(angdiff(hue, hue_edges(2))) && sign(angdiff(hue, hue_edges(2))) == sign(angdiff(hue_edges(1), hue_edges(2))))
            E4 += (min(abs(angdiff(hue, hue_edges(1))), abs(angdiff(hue, hue_edges(2)))))^2;
        end
    end
    global debug;
    if debug
        %keyboard
    end
    cost = 0*E1 + 1*E2 + 0*E3 + 0*E4;
endfunction
