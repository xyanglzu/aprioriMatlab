% �Ժ�ѡ��CK������֧�ֶȣ����õ�Ƶ���
% ���룺T       -- ����cell����
%      CK      -- k-���ѡ��
%      items   -- �����������������Ĳ��ظ�����ĿID
%      minSup  -- ��С֧�ֶ���ֵ
% �����FK      -- k-��Ƶ���
%      support -- ��ѡ����Ӧ��֧�ֶ�

function [Fk, support] = pruneCandidates(T, Ck, items, minSup)

    N = length(T);
    support = zeros(size(Ck,1),1);
    minSupCount = minSup * N;
         
    for i = 1:N
        % �õ���i���������Ŀ����
        t = find(ismember(items, T{i}));
        % �����ѡ����֧�ֶ�
        support(all(ismember(Ck,t),2)) = support(all(ismember(Ck,t),2)) + 1;
    end

    % �õ�Ƶ���
    Fk = Ck(support >= minSupCount, :);
end
