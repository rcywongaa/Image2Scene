function out_obj = minColorCost(scene_obj, ref_obj, hue_edges, corr_weights)
    global COL_H;
    NUM_ITERATIONS = 500; % 1min / 6000 iterations
    NUM_LABELS = size(scene_obj, 1);
    ALPHA = 0.003;
    global debug
    debug = 0;
    global debug_data
    debug_data = zeros(NUM_LABELS, NUM_ITERATIONS);
    reject_count = 0;
    accept_count = 0;
    costs = calcColorCost(scene_obj, ref_obj, hue_edges, corr_weights);
    derivatives = norm(dColorCost(scene_obj, ref_obj, hue_edges, corr_weights));
    printf("\n====================================\n");
    printf("Initial color cost = %f\n", costs);
    tic
    for iter = 1:NUM_ITERATIONS
        derivative = dColorCost(scene_obj, ref_obj, hue_edges, corr_weights);
        scene_obj(:, 1) = scene_obj(:, 1) - ALPHA*derivative;
        new_cost = calcColorCost(scene_obj, ref_obj, hue_edges, corr_weights);
        if new_cost > costs(end)
            printf('%d: %f (Increased)\n', iter, new_cost);
            debug = 1;
        else
            debug = 0;
        end
        costs = [costs; new_cost];
        derivatives = [derivatives; norm(derivative)];
        accept_count++;
        debug_data(:, iter) = derivative;
    end
    toc
    out_obj = scene_obj;
    out_obj(:, 1) = mod(out_obj(:, 1), 1);
    printf("Accepted: %d\n", accept_count);
    printf("Rejected: %d\n", reject_count);
    figure('Name', 'Cost');
    plot(costs);
    figure('Name', 'Derivatives');
    plot(derivatives);
    printf("Final color cost = %f\n", costs(end));
    printf("====================================\n");
    figure('Name', 'Output Scene');
    drawScene(out_obj);
    %out_obj(:, COL_H)
endfunction
