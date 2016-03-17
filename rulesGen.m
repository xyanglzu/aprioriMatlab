% 对一个频繁集生成规则
% 输入：FK      -- k-项频繁项
%      conseqs -- 每条规则的结果矩阵
%      S       -- 候选集及其支持度的映射
%      rules   -- 已有的规则
%      minConf -- 最小置信度阈值
% 输出：rules   -- 满足置信度的规则

function rules = rulesGen(Fk, conseqs, S, rules, minConf)
    
    m = size(conseqs, 2);
    % 频繁项的长度若比结果集超过1个元素，则继续生成规则
    if length(Fk) > m+1
        % 若规则的结果长度为1，则筛选出符合最小置信度阈值的规则
        if m == 1
            [~, rules] = pruneRules(Fk, conseqs, S, rules, minConf);
        end
        % 利用频繁项集生成候选集的方法，来得到m+1的结果集
        conseq1 = aprioriGen(conseqs, m+1);
        % 筛选出符合要求的规则
        [conseq1, rules] = pruneRules(Fk, conseq1, S, rules, minConf);
        
        % 若新得到的结果集仍不空，继续生成规则
        if ~isempty(conseq1)
            rules = rulesGen(Fk, conseq1, S, rules, minConf);
        end
    end
end