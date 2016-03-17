% k-1��Ƶ���ͨ�����Ӳ��õ���ѡ��
% ���룺freqSets -- k-1��Ƶ���
%      k        -- Ҫ�õ���Ƶ�������
% �����CK       -- �õ���k���ѡ��

function Ck = aprioriGen(freqSets, k)
    % 2���ѡ��ֻ��������ϵõ�����
    if k == 2
        Ck = combnk(freqSets,2);
    else
        Ck = [];
        num = size(freqSets,1);
        
        for i = 1:num-1
            for j = i+1:num
                % ������Ƶ����Ľ�������Ϊk-2�����������
                if length(intersect(freqSets(i,:), freqSets(j,:))) == k-2
                    Ck = [Ck; union(freqSets(i,:),freqSets(j,:))];
                end
            end
        end
        Ck = unique(Ck, 'rows');
    end
end