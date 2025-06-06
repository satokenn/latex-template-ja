%test02_BBとなっているところは各班のファイル名を入れる
dataBlocks=open_EMG('group5.txt');
%dataBlocksというデータができる。
%dataBlocks{1}は1つ目の、｛2｝は2つ目のデータが入っている。
%各データの1列目は時間、2列目は筋電データとなっている。


%描画してデータを確認。
%課題　plotを使用。
for i = 1 : 4
    switch i
        case 1
            str = 'MEC';
        case 2
            str = 'ダンベル1kg時';
        case 3
            str = 'ダンベル3kg時';
        case 4
            str = 'ダンベル5kg時';
    end
    figure('Name', [str, 'のデータ'], 'NumberTitle', 'off');
    plot(dataBlocks{i}(:,1), dataBlocks{i}(:,2));
    xlabel('時間(s)');
    ylabel('筋電(mV)');
    title([str, 'のデータ']);
end
%結果のデータ
%課題　resultsという名前に対してzerosを使って作っておく。
results = zeros(length(dataBlocks) - 1, 2);

%MVCの解析
%課題　MVCデータの準備。dataBlocks{1}に入っている
mvc_data = dataBlocks{1}(:, 2);


%baseline補正
%課題　図から安定しているところを確認し、その部分の差分を取る。
rest_mvc = 1 : 3000 ;
baseline = mean(mvc_data(rest_mvc));


re_mvc_data = mvc_data - baseline;
%整流（rectify）
%課題　絶対値化する
rectify_mvc_data = abs(re_mvc_data);


%最大値をとる
%課題　max関数を使う
max_mvc_data = max(rectify_mvc_data);


%各条件の解析(条件数だけ繰り返す)
for i = 2:length(dataBlocks)
%課題　条件データの準備。dataBlocks{*}に入っている。
each_data = (dataBlocks{i});
%baseline補正
%課題　図から安定しているところを確認し、その部分の差分を取る。
switch i
    case 2
        rest = 1 : 3200;
    case 3
        rest = 1 : 3500;
    case 4
        rest = 1 : 3400;
end
baseline = mean(each_data(rest, 2)); 
re_each_data = each_data(:, 2) - baseline; 


%整流（rectify）
%課題　絶対値化する
rectify_each_data = abs(re_each_data);


%ローパスフィルタ
%課題　butterで設計し、filtfiltを使ってローパスフィルタをかける
fs = 1000;
fc = 5;
[b, a] = butter(2, [fc/(fs/2)], 'low');
filter_each_data = filtfilt(b, a, rectify_each_data);
%課題　余裕がある人は自作でフィルタを作成する　課題説明※１参照


%筋活動
%課題　安定して活動している1000ms区間の平均値をとる
switch i
    case 2
        provisional_active_start = 3200;
    case 3
        provisional_active_start = 3500;
    case 4
        provisional_active_start = 3400;
end
min_var = Inf;
provisional_active_end = length(filter_each_data);


%最も安定してが活動している区間を決める
for j = provisional_active_start : provisional_active_end -1000
    provisional_active_data = j : (j + 1000 - 1);
    provisional_data = filter_each_data(provisional_active_data);
    var_data = var(provisional_data);
    
    if var_data < min_var
        min_var = var_data;
        active_start = j;
    end
end
active_end = active_start + 1000;
active = active_start : active_end;
active_data = filter_each_data((active)');
mean_emg = mean(active_data);




%確認
%課題　解析した区間が確かに最も安定した場所であるか描画して確認。
switch i
    case 2
        str = '1kg時';
    case 3
        str = '3kg時';
    case 4
        str = '5kg時';
end
figure('Name', ['ダンベル', str, 'の安定活動区間の確認'], 'NumberTitle', 'off');
plot(dataBlocks{i}(:, 1) , filter_each_data,'b');
title(['ダンベル', str, 'の安定活動区間の確認']);
hold on;
%安定区間の開始・終了を表示
x_start = dataBlocks{i}(active_start(1), 1);
x_end = dataBlocks{i}(active_end(1), 1);
y_limits = ylim;
line([x_start x_start], y_limits, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
line([x_end x_end], y_limits, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
xlabel('時間(s)');
ylabel('筋電(mV)')


%正規化
%課題　MVCでノーマライズする
normalized_emg = mean_emg / max_mvc_data;


%データの保管
%課題　resultsに結果を入れる。
results(i - 1, 2) = normalized_emg;
end
results(:, 1) = [1, 3, 5];

%描画
%課題　各条件毎に同様の解析を行い、横軸をダンベルの値、縦軸を筋電の値で描画する
figure('Name', '解析結果', 'NumberTitle', 'off');
p = plot(results(:, 1), results(:, 2), '-o', 'LineWidth', 3);
p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
p.MarkerEdgeColor = [1 0.5 0];
xticks([1 3 5]);
xlabel('ダンベル重量(kg)');
ylabel('正規化筋電(/MVC)');
title('解析結果');
grid on;


disp('解析結果:');
disp('ダンベル重量(kg) 正規化筋電(/MVC)');
disp(results);
