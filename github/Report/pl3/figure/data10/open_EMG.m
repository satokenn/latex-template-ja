function [dataBlocks]=open_EMG(fname)

% ファイル名
filename = fname;

% ファイルオープン
fid = fopen(filename, 'r');

% データブロックを格納するcell配列
dataBlocks = {};  % 例: {data1, data2, ...}

% 一時的なデータ格納用
currentData = [];

while ~feof(fid)
    line = strtrim(fgetl(fid));  % 1行取得して前後の空白を削除

    if isempty(line)
        continue;  % 空行はスキップ
    end

    % 数字データかどうかチェック（2つの数値がスペースやタブで区切られている）
    tokens = regexp(line, '^\s*([\d\.\-eE\+]+)[\s\t]+([\d\.\-eE\+]+)\s*$', 'tokens');

    if ~isempty(tokens)
        % 数字データなら、一時データに追加
        nums = str2double(tokens{1});
        currentData = [currentData; nums];
    else
        % 数字以外の行＝セクション切り替えと見なす
        if ~isempty(currentData)
            dataBlocks{end+1} = currentData;  % cell配列に追加
            currentData = [];  % 一時配列をクリア
        end
    end
end

% 最後のデータブロックも忘れず追加
if ~isempty(currentData)
    dataBlocks{end+1} = currentData;
end

fclose(fid);

