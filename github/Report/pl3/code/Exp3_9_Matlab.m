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

    % 必要な情報を抽出して行列 expos を作成
    % 行はサンプル数を示す
    % 列は 1.時間，2.画面の状態，3.左右どちらを見ているか，4.選択した方を見ているか，5.X座標

    end_time = eye_data(end, 1); % 最終行の時間 (終了時)
    adjusted_eye_time = eye_data(:, 1) - end_time; % 終了時を 0 とする
    times_to_zero = -2 * ((rows - 1) : -1 : 0); % キー押し時を 0 として時間を格納
    expos = zeros(rows, 5);
    expos(:, 1) = times_to_zero;
    expos(:, 2:4) = -1;
    
    %expos の時間列を「終了時0基準にした」eye_data の時間と比較
    [is_valid_time, idx_in_eye_data] = ismember(expos(:, 1), eye_data(:, 1) - eye_data(end, 1));
    
    % is_valid_time は expos の時間が eye_data の時間に存在するかどうかを示す論理配列
    % idx_in_eye_data は expos の時間が eye_data の時間に対応するインデックスを示す
    valid_rows = is_valid_time;
    
    % 欠損でない行に画面状態を代入に画面状態を代入
    expos(valid_rows, 2) = eye_data(idx_in_eye_data(valid_rows),3);
    
    % 欠損でない行に X座標を代入
    % 少数の値になるため 10倍して整数に変換
    expos(valid_rows, 5) = round(eye_data(idx_in_eye_data(valid_rows), 4)*10);
    
    % 画面の状態が 1 の時の X座標を抽出
    filation_rows =  expos(:, 2) == 1 & expos(:, 5) ~= -1;
    fixation_x_values = expos(filation_rows, 5);
    
    % X座標の平均を算出し，中心座標とする
    center_x = round(mean(fixation_x_values));
    
    % 画像提示時のうち，X座標がcenter_x より小さい行を 100，それより大きい行を 102 とする
    left_rows = expos(:, 2) == 2 & expos(:,5) < center_x;
    expos(left_rows, 3) = 100;

    right_rows = expos(:, 2) == 2 & expos(:,5) > center_x;
    expos(right_rows, 3) = 102;

    % どちらの画像が魅力的だったかを取得
    selected_side(i) = data(i,2);

    % 欠損値でないデータを探す
    not_missing = expos(:, 3) ~= -1;

    % キー出力データファイルと比較して，一致していれば 1 を出力
    expos(not_missing & expos(:, 3) == selected_side(i), 4)  = 1;
    
    % 一致していない場合と欠損値の場合は 0 を出力
    expos(not_missing & expos(:, 3) ~= selected_side(i), 4) = 0;

    % 魅力的だと判断した画像の方向と見ている方向が一致しているかのデータを
    % キー押し時の 1 秒前からキー押し時まで取得し，対応している試行の行に値を代入
    % ここではキー押し時を 0 として，-998 ms から 0 ms の間のデータを取得
    time_window = expos(:,1) >= -998 & expos(:,1) <= 0;
    
    % 該当する expos 4 列目を抽出して代入
    selected_segment = expos(time_window, 4);
    data_matrix(:, i + 1) = selected_segment;
end

% 各サンプリング時点についての処理
proportion_correct = zeros(500, 1);
for j = 1 : 500

    % 現在の行のうち，欠損値でないデータの論理配列を作成
    valid_trials = data_matrix(j, 2:end) ~= -1;

    % 欠損値でないデータの平均を計算
    valid_data = data_matrix(j, 2:end);
    mean_valid_data = mean(valid_data(valid_trials));
    proportion_correct(j, 1) = mean_valid_data;
end

x=-998:2:0;
plot(x,proportion_correct, "-");
xlabel("キー押し時(0)までの時間[ms]");
ylabel("視線が魅力的な画像に一致していた割合");
title("キー押し時前に視線が魅力的画像と一致していた割合の時間変化");
    