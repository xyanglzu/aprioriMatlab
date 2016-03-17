% 得到1-项频繁项集
% 输入：T      -- 事务cell矩阵
%      items  -- 所有事务中所包含的不重复的项目ID
%      minSup -- 最小支持度阈值
% 输出: F1     -- 1-项频繁项集在items中的索引
%      S      -- 所有项集索引及其支持度的映射
%      items  -- 所有事务中所包含的不重复的项目ID

function [F1, S, items]= getFreqOneItemsets(T, minSup)

    N = length(T);
    minSupCount = N * minSup;
    
    % 计算1-项候选项集及其支持度
    [items, ~, index] = unique([T{:}]');
    count = accumarray(index, 1);
    
    % 创建一个map映射来存储所有项集和其支持度
    S = containers.Map();
    for j = 1:length(items)
        S(num2str(j)) = count(j);
    end
    
    % 对候选集进行剪枝
    freqSet = find(count >= minSupCount);
    
    % 创建一个结构体来存储频繁项集
    F1 = struct('freqSets', freqSet);
end