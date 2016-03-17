% ��������Ĺ�������ŶȲ�ɾ�����ŶȲ���Ĺ���
% ���룺Fk            -- k-��Ƶ����
%      conseqs       -- ÿ������Ľ������
%      S             -- ��ѡ������֧�ֶȵ�ӳ��
%      rules         -- ���еĹ���
%      minConf       -- ��С���Ŷ���ֵ
% �����prunedConseqs -- �������Ŷȹ���Ľ����
%      rules         -- �������ŶȵĹ���

function [prunedConseqs, rules] = pruneRules(Fk, conseqs, S, rules, minConf)

    prunedConseqs = [];
    % �Թ���һһ����
    for i = 1:size(conseqs, 1);
        % �õ�һ������Ľ��
        conseq = conseqs(i,:);
        % �õ����������
        condit = setdiff(Fk, conseq);
        
        % �õ�Ƶ�����֧�ֶ�
        supFk =S(num2str(Fk));
        % �õ�����������֧�ֶ�
        supCondit =S(num2str(condit));
        % �õ���������֧�ֶ�
        supConseq =S(num2str(conseq));
        % �������Ŷ�
        conf = supFk / supCondit;
        % ����������
        lift = supFk/(supCondit*supConseq);

        if conf >= minConf
            prunedConseqs = [prunedConseqs; conseq];
            % ���ɹ���
            rule = struct('Condition',condit,'Consequence',conseq,...
                          'Confidence',conf,'Lift',lift,'Support',supFk);
            % ���¹���
            if isempty(rules)
                rules = rule;
            else
                rules = [rules, rule];
            end             
        end
    end
end