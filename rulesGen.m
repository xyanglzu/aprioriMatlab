% ��һ��Ƶ�������ɹ���
% ���룺FK      -- k-��Ƶ����
%      conseqs -- ÿ������Ľ������
%      S       -- ��ѡ������֧�ֶȵ�ӳ��
%      rules   -- ���еĹ���
%      minConf -- ��С���Ŷ���ֵ
% �����rules   -- �������ŶȵĹ���

function rules = rulesGen(Fk, conseqs, S, rules, minConf)
    
    m = size(conseqs, 2);
    % Ƶ����ĳ������Ƚ��������1��Ԫ�أ���������ɹ���
    if length(Fk) > m+1
        % ������Ľ������Ϊ1����ɸѡ��������С���Ŷ���ֵ�Ĺ���
        if m == 1
            [~, rules] = pruneRules(Fk, conseqs, S, rules, minConf);
        end
        % ����Ƶ������ɺ�ѡ���ķ��������õ�m+1�Ľ����
        conseq1 = aprioriGen(conseqs, m+1);
        % ɸѡ������Ҫ��Ĺ���
        [conseq1, rules] = pruneRules(Fk, conseq1, S, rules, minConf);
        
        % ���µõ��Ľ�����Բ��գ��������ɹ���
        if ~isempty(conseq1)
            rules = rulesGen(Fk, conseq1, S, rules, minConf);
        end
    end
end