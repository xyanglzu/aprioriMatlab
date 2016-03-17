% 计算给定的规则的置信度并删除置信度不足的规则
% 输入：Fk            -- k-项频繁项
%      conseqs       -- 每条规则的结果矩阵
%      S             -- 候选集及其支持度的映射
%      rules         -- 已有的规则
%      minConf       -- 最小置信度阈值
% 输出：prunedConseqs -- 满足置信度规则的结果集
%      rules         -- 满足置信度的规则

function [prunedConseqs, rules] = pruneRules(Fk, conseqs, S, rules, minConf)

    prunedConseqs = [];
    % 对规则一一遍历
    for i = 1:size(conseqs, 1);
        % 得到一条规则的结果
        conseq = conseqs(i,:);
        % 得到规则的条件
        condit = setdiff(Fk, conseq);
        
        % 得到频繁项的支持度
        supFk =S(num2str(Fk));
        % 得到规则条件的支持度
        supCondit =S(num2str(condit));
        % 得到规则结果的支持度
        supConseq =S(num2str(conseq));
        % 计算置信度
        conf = supFk / supCondit;
        % 计算提升度
        lift = supFk/(supCondit*supConseq);

        if conf >= minConf
            prunedConseqs = [prunedConseqs; conseq];
            % 生成规则
            rule = struct('Condition',condit,'Consequence',conseq,...
                          'Confidence',conf,'Lift',lift,'Support',supFk);
            % 更新规则
            if isempty(rules)
                rules = rule;
            else
                rules = [rules, rule];
            end             
        end
    end
end