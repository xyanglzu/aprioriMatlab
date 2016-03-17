% 从频繁项集中生成规则
% 输入：F       -- 1到k的频繁项集结构体
%      S       -- 所有项集及其支持度的映射
%      minConf -- 最小置信度阈值
% 输出：rules   -- 满足置信度的规则

function rules = generateRules(F, S, minConf)

    rules = struct('Condition',{},'Consequence',{},'Confidence',{},'Lift',{},'Support',{});
    % 从k=2开始生成规则
    for k = 2 : length(F)
        for n = 1 : size(F(k).freqSets,1)
            % 得到一个频繁项
            freqSet = F(k).freqSets(n,:);
            % 从频繁项freqSet中得到1-项结果集
            conseqs = freqSet';
            
            if k > 2
                rules = rulesGen(freqSet, conseqs, S, rules, minConf);
            else
                [~,rules] = pruneRules(freqSet, conseqs, S, rules, minConf);
            end
        end
    end