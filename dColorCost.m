function derivative = dColorCost(scene_obj, ref_obj, hue_edges, corr_weights)
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
    dE1 = zeros(size(scene_obj, 1), 1);
    dE2 = zeros(size(scene_obj, 1), 1);
    dE3 = zeros(size(scene_obj, 1), 1);
    dE4 = zeros(size(scene_obj, 1), 1);
    derivative = zeros(size(scene_obj, 1), 1);
    sum_of_neighbors = zeros(size(scene_obj, 1), 1);

    for index = 1:size(matching_labels)
        label = matching_labels(index);
        dE1(label) = 2*(nangdiff(scene_obj(label, COL_H), ref_obj(label, COL_H)));
    end

    for i = 1:size(matching_labels)
        label = matching_labels(i);
        hues = scene_obj(:, COL_H);
        for j = 1 : size(matching_labels)
            label2 = matching_labels(j);
            if (scene_obj(label, REGION) == scene_obj(label2, REGION) || scene_obj(label, PAIR) == scene_obj(label2, PAIR)) && (label != label2)
                sum_of_neighbors(label) += corr_weights(label, label2) * hues(label2);
            end
        end
    end
    for i = 1:size(matching_labels)
        label = matching_labels(i);
        hues = scene_obj(:, COL_H);
        for j = 1 : size(matching_labels)
            label2 = matching_labels(j);
            if (scene_obj(label, REGION) == scene_obj(label2, REGION) || scene_obj(label, PAIR) == scene_obj(label2, PAIR)) && (label != label2)
                dE2(label) += 2*(hues(label) - sum_of_neighbors(label)) + 2 * (hues(label2) - sum_of_neighbors(label2)) * -corr_weights(label2, label);
                if (label == 5)
                    %keyboard
                end

                %dE2(label) += 2*nangdiff(hues(label), corr_weights(label, label2) * hues(label2));
                %dE2(label2) += 2*nangdiff(hues(label), corr_weights(label, label2) * hues(label2))*(-corr_weights(label, label2));
            end
        end
    end
    %dE2 = rem(dE2, 1);

    K = 4;
    non_match_labels = setxor(scene_labels, matching_labels);
    for index = 1:size(non_match_labels)
        label = non_match_labels(index);
        [neighbors distances] = kNearestNeighbors(scene_obj(:, COORD_X:COORD_Y), scene_obj(label, COORD_X:COORD_Y), K+1);
        neighbors = neighbors(2:end);
        scene_obj(neighbors, COL_H);
        dominant_hue = mean(scene_obj(neighbors, COL_H));
        dE3(label) += 2*nangdiff(scene_obj(label, COL_H), dominant_hue);
        dE3(neighbors) += 2*nangdiff(scene_obj(label, COL_H), dominant_hue)*(-1/K);
    end

    for index = 1:size(scene_labels)
        label = scene_labels(index);
        hue = mod(scene_obj(label, COL_H), 1)*2*pi;
        %if (hue_edges(1) < hue_edges(2) && (hue < hue_edges(1) || hue > hue_edges(2))) || ...
                %(hue_edges(2) < hue_edges(1) && (hue < hue_edges(1) && hue > hue_edges(2)))
        if !(sign(angdiff(hue_edges(1), hue)) == sign(angdiff(hue, hue_edges(2))) && sign(angdiff(hue, hue_edges(2))) == sign(angdiff(hue_edges(1), hue_edges(2))))
            diffs = [angdiff(hue, hue_edges(1)); angdiff(hue, hue_edges(2))];
            [dummy, index] = min(abs(diffs));
            dE4(label) = 2*diffs(index)/(2*pi);
        end
    end
    global debug;
    if debug
        %keyboard
    end
    derivative = 0*dE1 + 1*dE2 + 0*dE3 + 0*dE4;
endfunction
