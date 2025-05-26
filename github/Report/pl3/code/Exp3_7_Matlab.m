% パラメータ
currentPath=pwd;
imgpath=fullfile(pwd,'img');                        % イメージファイルのパス
% 課題 trialnumber=という形で作成する。            % 刺激画像ファイルのペアの数
trialnumber = 2;                                    % ★修正: 試行数を2に設定
h=640;                                              % 刺激画像の横のサイズ（pix）
v=480;                                              % 刺激画像の縦のサイズ（pix）
textcolor=0;                                        % 文字色 (黒)
% 課題 bgcolor=という形で作成する。                % 背景色
bgcolor = 255;                                      % ★修正: 背景色を白に設定 (白は255)
% 課題 fxcolor = という形で作成する。                % 固視点色
fxcolor = 0;                                        % ★修正: 固視点色を黒に設定 (黒は0)


try
    %おやくそくの表記
    screenNumber=max(Screen('Screens'));
    [window, rectW]=Screen('OpenWindow', screenNumber); %rectWは画面の大きさ
    % 画面の基本設定
    rectI=[0 0 h v];                              % 刺激画像の大きさ
    margin=220;                                   % 画像の左右端とウィンドウ端との距離

    % 刺激画像の呈示領域（左）
    rectIL=[margin rectW(4)/2-rectI(4)/2 margin+rectI(3) rectW(4)/2+rectI(4)/2];

    % 刺激画像の呈示領域（右）
    % 課題 上の刺激画像の呈示領域（左）を参考に作成する
    rectIR=[rectW(3)-margin-rectI(3) rectW(4)/2-rectI(4)/2 rectW(3)-margin rectW(4)/2+rectI(4)/2]; % ★修正: 右側の画像呈示位置を計算

    % 固視点の呈示領域
    rectF=[40 4]; % [幅 高さ]
    rectF1=[rectW(3)/2-rectF(1)/2 rectW(4)/2-rectF(2)/2 rectW(3)/2+rectF(1)/2 rectW(4)/2+rectF(2)/2]; % 横棒
    % 課題 上のrectF1を参考にrectF2というのを作成する
    rectF_vertical = [rectF(2) rectF(1)]; % 縦棒用に幅と高さを入れ替え
    rectF2=[rectW(3)/2-rectF_vertical(1)/2 rectW(4)/2-rectF_vertical(2)/2 rectW(3)/2+rectF_vertical(1)/2 rectW(4)/2+rectF_vertical(2)/2]; % ★修正: 縦棒

    % 実験結果
    %このようにzerosで用意したほうが処理が早くなる。
    results=zeros(trialnumber,3); %
    % 試行番号
    results(:,1)=1:trialnumber; %

    %刺激画像ファイルの準備　ここから
    %刺激画像は男性女性の画像にも対応できるようにしているため込み入っているがここでは気にしなくてよい。
    % 画像呈示順番リスト
    imgLnames=char(); %
    imgRnames=char(); %
    % イラストファイルリストの取得
    imglist=getFilelist(imgpath, '\w*.BMP'); %
    fimglist = imglist(1:2:end); %
    mimglist = imglist(2:2:end); %
    % イラストペア呈示順の決定
    pairs=exp4i_setpairs(fimglist,mimglist,trialnumber); %
    %刺激画像ファイルの準備　ここまで

    % 開始画面の表示
    HideCursor;                                           % カーソルを隠す
    Screen(window,'FillRect',bgcolor);                    % 背景ウィンドウの描画
    Screen(window,'WaitBlanking');                        % モニタと同期を取る
    WaitSecs(1.0);                                        % 1.0秒待つ

    for i=1:trialnumber

        %刺激画像ファイルの準備　ここから
        %刺激画像は男性女性の画像にも対応できるようにしているため込み入っているがここでは気にしなくてよい。
        if(pairs(i,1)==0) %
            imglist=fimglist; %
        else
            imglist=mimglist; %
        end
        % 刺激画像ファイル1を設定する。
        imgL=imglist(pairs(i,2)); %
        imgLnames=char(imgLnames, imgL.name); %
        fileL=imread(imgL.name); %
        clear imgL; %
        % 刺激画像ファイル2を設定する。
        imgR=imglist(pairs(i,3)); %
        imgRnames=char(imgRnames, imgR.name); %
        fileR=imread(imgR.name); %
        clear imgR; %
         %刺激画像ファイルの準備　ここまで

        % 固視点を呈示する。
        Screen(window,'FillRect',bgcolor);                    % 背景ウィンドウの描画
        Screen(window,'FillRect',fxcolor,rectF1);             % 固視点（横棒）の描画
        Screen(window,'FillRect',fxcolor,rectF2);             % 固視点（縦棒）の描画
        [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen(window, 'Flip'); %

        % 課題 　　3秒間固視点を維持する
        WaitSecs(3.0);                                        % ★修正: 3秒待つ

        % 回答キーを制限する。
        RestrictKeysForKbCheck([KbName('g'), KbName('j')]); %

        % 刺激画像を呈示する。
        Screen(window,'FillRect',bgcolor);                    % 背景ウィンドウの描画
        Screen(window,'PutImage',fileL,rectIL);               % 左画像の描画
        Screen(window,'PutImage',fileR,rectIR);               % 右画像の描画
        [VBLTimestamp StimulusOnsetTime FlipTimestamp Missed Beampos] = Screen(window, 'Flip');     % FlipTimestampが刺激画像を呈示した時間になる
        clear fileL fileR; %

        % 回答キーが押されたらキーコードと反応時間を取得する。
        [secs, keyCode1, deltaSecs] = KbWait([], 3); %
        res = find(keyCode1);   %  キーコードの取得

         % 回答（キーコード） （gはコード71、jはコード74）
         results(i,2) = res(1); % 最初に押されたキーを記録

         % 反応時間
         % 課題    %回答を参考にして、反応時間をresultsの3列目に入れる。
         results(i,3) = tKey - stimOnset; % ★修正: 反応時間を計算して記録

         % adds 100 msec of data to catch final events
         WaitSecs(0.1); %

         % 次の試行に行くためにreturnを押すように指示。
         % 既存の関数を使用。
         exp4i_shortrest(window,rectW,bgcolor,textcolor); %

         % return キーが押されたら次の試行に進む。
         RestrictKeysForKbCheck(KbName('return')); %
         KbWait([], 3); % returnキーが押されるのを待つ (keyCode2は使わないので削除)

    end
    WaitSecs(0.1);	% wait a while to record a few more samples

   %データの保存。カンマ区切り。
   % 課題
   % writematrixを使ってデータをカンマ区切りで保存する。ファイル名はexp3_7_**.csvとする。**には班の数字を入れる。
   group_number = '05'; % ★修正: ここに班の数字（例: '01'）を入れる
   filename = ['exp3_7_' group_number '.csv'];
   writematrix(results, filename);                  % ★修正: 結果をCSVファイルに保存

   Screen('CloseAll'); %
   ShowCursor; %

catch

    Screen('CloseAll');
    ShowCursor;
    psychrethrow(psychlasterror); %

end