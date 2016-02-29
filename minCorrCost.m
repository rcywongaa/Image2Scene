function weights = minCorrCost(obj)
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
    global NUM_LABELS;
    NUM_ITERATIONS = 3; %1 min / 1000 iterations
    ALPHA = 0.001;
    reject_count = 0;
    accept_count = 0;
    % TODO: Only the weights of neighbors need to sum to one!!
    weights = zeros(NUM_LABELS);
    %weights = ones(NUM_LABELS) / NUM_LABELS;


    %options = optimoptions('fmincon','GradObj','on');
    %[weights, cost] = fmincon(@minfunc, weights, [], [], ones(NUM_LABELS), ones(NUM_LABELS, 1), [], [], [], options);

    printf("\n====================================\n");
    printf("Initial correlation cost = %f\n", costfunc(weights(:)));
    [x, cost, info, iter] = sqp(weights(:), {@costfunc}, @constfunc, [], -1, 1);
    %[x, cost, info, iter] = sqp(weights(:), {@costfunc, @gradfunc}, @constfunc, [], 0, 1);
    %[x, cost, info, iter] = sqp(weights(:), {@costfunc, @gradfunc}, @constfunc);
    weights = vec2mat(x, NUM_LABELS);
    weights
    printf("SQP result: %d, # iterations: %d\n", info, iter);
    printf("Final correlation cost = %f\n", cost);
    printf("====================================\n");

    %opt.algorithm = NLOPT_LN_COBYLA;
    %opt.min_objective = @minfunc;





%{
    orig_cost = calcCorrCost(obj, weights);
    costs = orig_cost;
    printf("\n====================================\n");
    printf("Initial cost = %f\n", costs);
    tic
    for iter = 1:NUM_ITERATIONS
        derivative = dCorrCost(obj, weights);
        weights = weights - ALPHA*derivative;

%TODO
%printf("Cost before normalizing: %f\n", costs(end));
nonzeros = logical(sum(weights, 2));
%warning: quotient: automatic broadcasting operation applied -- OK
weights(nonzeros, :) = weights(nonzeros, :) ./ sum(weights(nonzeros, :), 2);
%printf("Cost after normalizing: %f\n", calcCorrCost(obj, weights));

        new_cost = calcCorrCost(obj, weights);
        costs = [costs; new_cost];
        accept_count++;
    end
    toc


    printf("Accepted: %d\n", accept_count);
    printf("Rejected: %d\n", reject_count);
    figure
    plot(costs);
    printf("Final cost = %f\n", costs(end));
    printf("====================================\n");
%}
endfunction
