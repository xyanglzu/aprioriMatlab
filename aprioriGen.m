% k-1项频繁项集通过连接步得到候选集
% 输入：freqSets -- k-1项频繁项集
%      k        -- 要得到的频繁项集长度
% 输出：CK       -- 得到的k项候选集

function Ck = aprioriGen(freqSets, k)
    % 2项候选集只需排列组合得到即可
    if k == 2
        Ck = combnk(freqSets,2);
    else
        Ck = [];
        num = size(freqSets,1);
        
        for i = 1:num-1
            for j = i+1:num
                % 若两个频繁项集的交集长度为k-2，则可以连接
                if length(intersect(freqSets(i,:), freqSets(j,:))) == k-2
                    Ck = [Ck; union(freqSets(i,:),freqSets(j,:))];
                end
            end
        end
        Ck = unique(Ck, 'rows');
    end
end