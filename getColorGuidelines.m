%Note to self: Always prefer jpg images

function [type, angle, edges] = getColorGuidelines(file_name)
    WHEEL_RADIUS = 1;
    WHEEL_CENTER = [0, 0];
    HUE_SIZE = 360;
    hue_bins = zeros(HUE_SIZE, 1);
    rgb_map = imread(file_name);

    %Show image
    figure
    subplot(2, 2, 1);
    imshow(rgb_map);
    num_pixels = size(rgb_map, 1) * size(rgb_map, 2);

    %Show color histogram
    hsv_map = rgb2hsv(rgb_map);
    BWG_THRESHOLD = 0.15;
    avg_saturation = mean(mean(hsv_map(:, :, 2)))
    if avg_saturation < BWG_THRESHOLD
        printf("Hue Template Type: B-W-G\n");
        type = 11;
        deg = 0;
        return
    end
    num_rows = size(hsv_map, 1);
    num_cols = size(hsv_map, 2);
    for row = 1:num_rows
        for col = 1:num_cols
            hue_bins(fixAngle(hsv_map(row, col, 1) * 360), 1) ++;
        end
    end
    hue_norm = hue_bins / max(hue_bins);
    subplot(2, 1, 2);
    plot(hue_norm);
    axis([1 360 0 1]);
    colormap(hsv(360));
    colorbar("SouthOutside");

    x_pts = zeros(2, HUE_SIZE);
    y_pts = zeros(2, HUE_SIZE);
    colors = zeros(HUE_SIZE, 3);
    TYPE_i = 1;
    TYPE_V = TYPE_i + 1;
    TYPE_I = TYPE_V + 1;
    TYPE_Im = TYPE_I + 1;
    TYPE_X = TYPE_Im + 1;
    TYPE_Xm = TYPE_X + 1;
    TYPE_Y = TYPE_Xm + 1;
    TYPE_Ym = TYPE_Y + 1;
    TYPE_L = TYPE_Ym + 1;
    TYPE_Lm = TYPE_L + 1;
    global NUM_TYPES = TYPE_Lm;
    score_map = zeros(NUM_TYPES, HUE_SIZE);
    SECTOR_WIDTH_i = 20;
    SECTOR_WIDTH_V = 60; %45
    SECTOR_WIDTH_I = 20;
    SECTOR_ANGLE_I = 160;
    SECTOR_WIDTH_X = 50;
    SECTOR_ANGLE_X = 160;
    SECTOR_WIDTH1_Y = 50;
    SECTOR_WIDTH2_Y = 25;
    SECTOR_ANGLE_Y = 160;
    SECTOR_WIDTH_L = 50;
    SECTOR_ANGLE_L = 90;
    global SECTOR;
    SECTOR = [ ...
        SECTOR_WIDTH_i, 0, 0; ...
        SECTOR_WIDTH_V, 0, 0; ...
        SECTOR_WIDTH_I, SECTOR_ANGLE_I, SECTOR_WIDTH_I; ...
        SECTOR_WIDTH_I, 360 - SECTOR_ANGLE_I, SECTOR_WIDTH_I; ...
        SECTOR_WIDTH_X, SECTOR_ANGLE_X, SECTOR_WIDTH_X; ...
        SECTOR_WIDTH_X, 360 - SECTOR_ANGLE_X, SECTOR_WIDTH_X; ...
        SECTOR_WIDTH1_Y, SECTOR_ANGLE_Y, SECTOR_WIDTH2_Y; ...
        SECTOR_WIDTH1_Y, 360 - SECTOR_ANGLE_Y, SECTOR_WIDTH2_Y; ...
        SECTOR_WIDTH_L, SECTOR_ANGLE_L, SECTOR_WIDTH_L; ...
        SECTOR_WIDTH_L, 360 - SECTOR_ANGLE_L, SECTOR_WIDTH_L ...
        ];
    %TODO: Do something for black & white image
    subplot(2, 2, 2);
    for deg = 1:HUE_SIZE
        %Draw colorwheel
        radians = deg / HUE_SIZE * 2 * pi;
        start_coords = WHEEL_CENTER + WHEEL_RADIUS .* [cos(radians), sin(radians)];
        end_coords = WHEEL_CENTER + WHEEL_RADIUS * (1 - hue_norm(deg)) .* [cos(radians), sin(radians)];
        x_pts(:, deg) = [start_coords(1), end_coords(1)];
        y_pts(:, deg) = [start_coords(2), end_coords(2)];
        colors(deg, :) = hsv2rgb([deg / HUE_SIZE, 1, 1]);
        plot([start_coords(1), end_coords(1)], [start_coords(2), end_coords(2)], 'Color',  hsv2rgb([deg / 360.0, 1, 1]));
        hold on
        %Calculate guideline score
        score_map = addScoreMap(score_map, deg, hue_bins(deg));
    end
    axis square;

    %Find sector
    %Smallest sector covering at least 80%
    THRESHOLD = 0.80;
    %[amount, index] = (max(score_map, [], 2));
    %[index, amount]
    [hasFound, type] = max((max(score_map, [], 2) >= THRESHOLD*num_pixels) ./ (SECTOR(:, 1) + SECTOR(:, 3)));
    if hasFound != 0
        [count, angle] = max(score_map(type, :));
        printf("Good match! Pixel Coverage: %d%%\n", count/num_pixels*100);
        printf("Hue Template Type: %d (1 = i, 2 = V, 3-4 = I, 5-6 = X, 7-8 = Y, 9-10 = L) \nHue Degrees: %d\n", type, angle);
    else
        [count, index] = max(score_map(:));
        [type, angle] = ind2sub(size(score_map), index);
        printf("Bad match... Pixel Coverage: %d%%\n", count/num_pixels*100);
        printf("Hue Template Type: %d (1 = i, 2 = V, 3-4 = I, 5-6 = X, 7-8 = Y, 9-10 = L) \nHue Degrees: %d\n", type, angle);
    end
    edges = drawSector(angle, SECTOR(type, :));
    %drawSector(199, SECTOR(8,:)); %Debug
    hold off
endfunction 
