%test02_BB�ƂȂ��Ă���Ƃ���͊e�ǂ̃t�@�C����������
dataBlocks=open_EMG('group5.txt');
%dataBlocks�Ƃ����f�[�^���ł���B
%dataBlocks{1}��1�ڂ́A�o2�p��2�ڂ̃f�[�^�������Ă���B
%�e�f�[�^��1��ڂ͎��ԁA2��ڂ͋ؓd�f�[�^�ƂȂ��Ă���B

%�`�悵�ăf�[�^���m�F�B
%�ۑ�@plot���g�p�B
for i = 1 : 4
    switch i
        case 1
            str = 'MEC';
        case 2
            str = '�_���x��1kg��';
        case 3
            str = '�_���x��3kg��';
        case 4
            str = '�_���x��5kg��';
    end
    figure('Name', [str, '�̃f�[�^'], 'NumberTitle', 'off');
    plot(dataBlocks{i}(:,1), dataBlocks{i}(:,2));
    xlabel('����(s)');
    ylabel('�ؓd(mV)');
    title([str, '�̃f�[�^']);
end
%���ʂ̃f�[�^
%�ۑ�@results�Ƃ������O�ɑ΂���zeros���g���č���Ă����B
results = zeros(length(dataBlocks) - 1, 2);



%MVC�̉��
%�ۑ�@MVC�f�[�^�̏����BdataBlocks{1}�ɓ����Ă���
mvc_data = dataBlocks{1}(:, 2);

%baseline�␳
%�ۑ�@�}������肵�Ă���Ƃ�����m�F���A���̕����̍��������B
rest_mvc = 1 : 3000 ;
baseline = mean(mvc_data(rest_mvc));

re_mvc_data = mvc_data - baseline;
%�����irectify�j
%�ۑ�@��Βl������
rectify_mvc_data = abs(re_mvc_data);

%�ő�l���Ƃ�
%�ۑ�@max�֐����g��
max_mvc_data = max(rectify_mvc_data);

%�e�����̉��(�����������J��Ԃ�)
for i = 2:length(dataBlocks)
%�ۑ�@�����f�[�^�̏����BdataBlocks{*}�ɓ����Ă���B
each_data = (dataBlocks{i});
%baseline�␳
%�ۑ�@�}������肵�Ă���Ƃ�����m�F���A���̕����̍��������B
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

%�����irectify�j
%�ۑ�@��Βl������
rectify_each_data = abs(re_each_data);

%���[�p�X�t�B���^
%�ۑ�@butter�Ő݌v���Afiltfilt���g���ă��[�p�X�t�B���^��������
fs = 1000;
fc = 5;
[b, a] = butter(2, [fc/(fs/2)], 'low');
filter_each_data = filtfilt(b, a, rectify_each_data);
%�ۑ�@�]�T������l�͎���Ńt�B���^���쐬����@�ۑ�������P�Q��

%�؊���
%�ۑ�@���肵�Ċ������Ă���1000ms��Ԃ̕��ϒl���Ƃ�
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

%�ł����肵�Ă��������Ă����Ԃ����߂�
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


%�m�F
%�ۑ�@��͂�����Ԃ��m���ɍł����肵���ꏊ�ł��邩�`�悵�Ċm�F�B
switch i
    case 2
        str = '1kg��';
    case 3
        str = '3kg��';
    case 4
        str = '5kg��';
end
figure('Name', ['�_���x��', str, '�̈��芈����Ԃ̊m�F'], 'NumberTitle', 'off');
plot(dataBlocks{i}(:, 1) , filter_each_data,'b');
title(['�_���x��', str, '�̈��芈����Ԃ̊m�F']);
hold on;
%�����Ԃ̊J�n�E�I����\��
x_start = dataBlocks{i}(active_start(1), 1);
x_end = dataBlocks{i}(active_end(1), 1);
y_limits = ylim;
line([x_start x_start], y_limits, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
line([x_end x_end], y_limits, 'Color', 'r', 'LineStyle', '--', 'LineWidth', 1.5);
xlabel('����(s)');
ylabel('�ؓd(mV)')

%���K��
%�ۑ�@MVC�Ńm�[�}���C�Y����
normalized_emg = mean_emg / max_mvc_data;

%�f�[�^�̕ۊ�
%�ۑ�@results�Ɍ��ʂ�����B
results(i - 1, 2) = normalized_emg;
end
results(:, 1) = [1, 3, 5];

%�`��
%�ۑ�@�e�������ɓ��l�̉�͂��s���A�������_���x���̒l�A�c�����ؓd�̒l�ŕ`�悷��
figure('Name', '��͌���', 'NumberTitle', 'off');
p = plot(results(:, 1), results(:, 2), '-o', 'LineWidth', 3);
p.MarkerFaceColor = [1 0.5 0];
p.MarkerSize = 8;
p.MarkerEdgeColor = [1 0.5 0];
xticks([1 3 5]);
xlabel('�_���x���d��(kg)');
ylabel('���K���ؓd(/MVC)');
title('��͌���');
grid on;

disp('��͌���:');
disp('�_���x���d��(kg) ���K���ؓd(/MVC)');
disp(results);


%%%�����܂łň�xTA�m�F%%%

%�؊����̃I���Z�b�g�𒲂ׂ�B
%���[�p�X�t�B���^��20Hz
%�S��Ԃ̍��v��95%�𖞂�����Ԃ��ł��Z���Ƃ���̍ŏ��̏ꏊ���؊����̊J�n�ꏊ�i�I���Z�b�g�j�Ƃ���B
%�`�悵�ăI���Z�b�g���K�؂��m�F�B

%%%�����܂łň�xTA�m�F%%%

%�S�Ă̔ǂ̉�͂𓯂��v���O�����Ŏ����I�ɉ�͂ł���v���O���������A�K�؂ɉ�͂��ł��Ă��邩�`�悵�Ċm�F�B












