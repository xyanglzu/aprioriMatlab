% �õ�1-��Ƶ���
% ���룺T      -- ����cell����
%      items  -- �����������������Ĳ��ظ�����ĿID
%      minSup -- ��С֧�ֶ���ֵ
% ���: F1     -- 1-��Ƶ�����items�е�����
%      S      -- �������������֧�ֶȵ�ӳ��
%      items  -- �����������������Ĳ��ظ�����ĿID

function [F1, S, items]= getFreqOneItemsets(T, minSup)

    N = length(T);
    minSupCount = N * minSup;
    
    % ����1-���ѡ�����֧�ֶ�
    [items, ~, index] = unique([T{:}]');
    count = accumarray(index, 1);
    
    % ����һ��mapӳ�����洢���������֧�ֶ�
    S = containers.Map();
    for j = 1:length(items)
        S(num2str(j)) = count(j);
    end
    
    % �Ժ�ѡ�����м�֦
    freqSet = find(count >= minSupCount);
    
    % ����һ���ṹ�����洢Ƶ���
    F1 = struct('freqSets', freqSet);
end