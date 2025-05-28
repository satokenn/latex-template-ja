function [dataBlocks]=open_EMG(fname)

% �t�@�C����
filename = fname;

% �t�@�C���I�[�v��
fid = fopen(filename, 'r');

% �f�[�^�u���b�N���i�[����cell�z��
dataBlocks = {};  % ��: {data1, data2, ...}

% �ꎞ�I�ȃf�[�^�i�[�p
currentData = [];

while ~feof(fid)
    line = strtrim(fgetl(fid));  % 1�s�擾���đO��̋󔒂��폜

    if isempty(line)
        continue;  % ��s�̓X�L�b�v
    end

    % �����f�[�^���ǂ����`�F�b�N�i2�̐��l���X�y�[�X��^�u�ŋ�؂��Ă���j
    tokens = regexp(line, '^\s*([\d\.\-eE\+]+)[\s\t]+([\d\.\-eE\+]+)\s*$', 'tokens');

    if ~isempty(tokens)
        % �����f�[�^�Ȃ�A�ꎞ�f�[�^�ɒǉ�
        nums = str2double(tokens{1});
        currentData = [currentData; nums];
    else
        % �����ȊO�̍s���Z�N�V�����؂�ւ��ƌ��Ȃ�
        if ~isempty(currentData)
            dataBlocks{end+1} = currentData;  % cell�z��ɒǉ�
            currentData = [];  % �ꎞ�z����N���A
        end
    end
end

% �Ō�̃f�[�^�u���b�N���Y�ꂸ�ǉ�
if ~isempty(currentData)
    dataBlocks{end+1} = currentData;
end

fclose(fid);

