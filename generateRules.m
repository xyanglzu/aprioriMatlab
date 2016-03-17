% ��Ƶ��������ɹ���
% ���룺F       -- 1��k��Ƶ����ṹ��
%      S       -- ���������֧�ֶȵ�ӳ��
%      minConf -- ��С���Ŷ���ֵ
% �����rules   -- �������ŶȵĹ���

function rules = generateRules(F, S, minConf)

    rules = struct('Condition',{},'Consequence',{},'Confidence',{},'Lift',{},'Support',{});
    % ��k=2��ʼ���ɹ���
    for k = 2 : length(F)
        for n = 1 : size(F(k).freqSets,1)
            % �õ�һ��Ƶ����
            freqSet = F(k).freqSets(n,:);
            % ��Ƶ����freqSet�еõ�1-������
            conseqs = freqSet';
            
            if k > 2
                rules = rulesGen(freqSet, conseqs, S, rules, minConf);
            else
                [~,rules] = pruneRules(freqSet, conseqs, S, rules, minConf);
            end
        end
    end