% �õ����е�Ƶ���
% ���룺transactions -- ����cell����
%      minSup       -- ��С֧�ֶ���ֵ
% �����F            -- 1��k��Ƶ����ṹ��
%      S            -- ���������֧�ֶȵ�ӳ��
%      items        -- �����������������Ĳ��ظ�����ĿID

function [F, S, items] = findFreqItemsets(transactions, minSup)

    [F, S, items] = getFreqOneItemsets(transactions, minSup);
    
    if isempty(F.freqSets)
        fprintf('����С֧�ֶ���û���ҵ�Ƶ����Ŀ��\n');
        return;
    end
    
    % �õ����е�k-��Ƶ���(k>2)
    k = 2;
    while true
        % ���ɺ�ѡ��
        Ck = aprioriGen(F(k-1).freqSets, k);   
        % �õ�Ƶ���
        [Fk, support] = pruneCandidates(transactions, Ck, items,minSup);

        % ������Ŀ����֧�ֶȵ�ӳ��
        if ~isempty(support)
            mapS = containers.Map();
            
            for i = 1:length(support)
                mapS(num2str(Ck(i,:))) = support(i);
            end
            
            S = [S; mapS];
        else
            break;
        end
        
        % �洢k-��Ƶ����Ŀ��
        if ~isempty(Fk)
            F(k).freqSets = Fk;
            k = k + 1;
        else
            break;
        end
    end
    
