% 对候选集CK计算其支持度，并得到频繁项集
% 输入：T       -- 事务cell矩阵
%      CK      -- k-项候选集
%      items   -- 所有事务中所包含的不重复的项目ID
%      minSup  -- 最小支持度阈值
% 输出：FK      -- k-项频繁项集
%      support -- 候选集对应的支持度

function [Fk, support] = pruneCandidates(T, Ck, items, minSup)

    N = length(T);
    support = zeros(size(Ck,1),1);
    minSupCount = minSup * N;
         
    for i = 1:N
        % 得到第i个事务的项目索引
        t = find(ismember(items, T{i}));
        % 计算候选集的支持度
        support(all(ismember(Ck,t),2)) = support(all(ismember(Ck,t),2)) + 1;
    end

    % 得到频繁项集
    Fk = Ck(support >= minSupCount, :);
end
