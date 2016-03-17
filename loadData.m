% �����ݼ��ļ��ж�ȡ����
% ���룺filename     -- �ļ���
% �����transactions -- ����cell����ÿһ����һ�������е���Ŀ��
%      items        -- �����������������Ĳ��ظ�����ĿID

function transactions = loadData(filename)

    % ���ļ���ÿһ�����ַ�����ʽ�洢��cell������
    fid = fopen(filename);
    lines = textscan(fid,'%s','delimiter','\n');
    lines = lines{1}; % ��cell���齵��
    fclose(fid);

    % ��ÿһ�е�cell����ת�������־��󣬲��洢��transactions��
    transactions = cell(size(lines));

    for i = 1:length(lines)
        line = textscan(lines{i},'%d');
        transactions{i} = line{1}';
    end

end