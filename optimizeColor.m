function optimizeColor(scene_file, ref_file)
    close all
    scene_file="";
    ref_file="analog_bedroom.jpg";
    global scene_obj;
    global ref_obj;
    scene_obj = readScene(scene_file); %Hard-coded
    ref_obj = segmentImage(ref_file); %Hard-coded
    global NUM_LABELS = size(scene_obj, 1);
    weights = minCorrCost(ref_obj);
    [hue_template, angle, hue_edges] = getColorGuidelines(ref_file);
    minColorCost(scene_obj, ref_obj, hue_edges, weights);
endfunction
