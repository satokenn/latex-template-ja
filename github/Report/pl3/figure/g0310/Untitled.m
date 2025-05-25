% 初期設定
clear all;
filename = 'exp4i_g0310.csv';
data = csvread(filename);

choice = data(:,2,:);
num_trials = length(choice);
sampling_freq = 500;
data_matrix = zeros(500, num_trials + 1);
time = -998:2:0;
data_matrix(:,1) = time;

for i = 1:num_trials
    filename = ['g0310.asc_TRIAL_'  num2str(i)  '.csv'];
    eye_data = csvread(filename);
    [rows, cols] = size(eye_data);
    end_time = eye_data(end, 1);
    
    adjusted_eye_time = eye_data(:, 1) - end_time;
    times_to_zero = -2 * ((rows - 1) : -1 : 0);
    expos = zeros(rows, 5);
    expos(:, 1) = times_to_zero;
    expos(:, 2:4) = -1;
    [is_valid_time, idx_in_eye_data] = ismember(expos(:, 1), eye_data(:, 1) - eye_data(end, 1));
    valid_rows = is_valid_time;
    expos(valid_rows, 2) = eye_data(idx_in_eye_data(valid_rows),3);
    expos(valid_rows, 5) = round(eye_data(idx_in_eye_data(valid_rows), 4)*10);
    filation_rows =  expos(:, 2) == 1 & expos(:, 5) ~= -1;
    fixation_x_values = expos(filation_rows, 5);
    center_x = round(mean(fixation_x_values));
    left_rows = expos(:, 2) == 2 & expos(:,5) < center_x;
    expos(left_rows, 3) = 100;
    right_rows = expos(:, 2) == 2 & expos(:,5) > center_x;
    expos(right_rows, 3) = 102;
    selected_side(i) = data(i,2);
    not_missing = expos(:, 3) ~= -1;
    expos(not_missing & expos(:, 3) == selected_side(i), 4)  = 1;
    
    expos(not_missing & expos(:, 3) ~= selected_side(i), 4) = 0;
    time_window = expos(:,1) >= -998 & expos(:,1) <= 0;
    selected_segment = expos(time_window, 4);
    data_matrix(:, i + 1) = selected_segment;
end

proportion_correct = zeros(500, 1);
for j = 1 : 500
    valid_trials = data_matrix(j, 2:end) ~= -1;
    valid_data = data_matrix(j, 2:end);
    mean_valid_data = mean(valid_data(valid_trials));
    proportion_correct(j, 1) = mean_valid_data;
end

x=-998:2:0;
plot(x,proportion_correct, "-");
xlabel("キー押し時(0)までの時間[ms]");
ylabel("視線が魅力的な画像に一致していた割合");
title("キー押し時前に視線が魅力的画像と一致していた割合の時間変化");
    