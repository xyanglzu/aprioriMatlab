% 得到所有的频繁项集
% 输入：transactions -- 事务cell矩阵
%      minSup       -- 最小支持度阈值
% 输出：F            -- 1到k的频繁项集结构体
%      S            -- 所有项集及其支持度的映射
%      items        -- 所有事务中所包含的不重复的项目ID

function [F, S, items] = findFreqItemsets(transactions, minSup)

    [F, S, items] = getFreqOneItemsets(transactions, minSup);
    
    if isempty(F.freqSets)
        fprintf('该最小支持度下没有找到频繁项目集\n');
        return;
    end
    
    % 得到所有的k-项频繁项集(k>2)
    k = 2;
    while true
        % 生成候选集
        Ck = aprioriGen(F(k-1).freqSets, k);   
        % 得到频繁项集
        [Fk, support] = pruneCandidates(transactions, Ck, items,minSup);

        % 更新项目集和支持度的映射
        if ~isempty(support)
            mapS = containers.Map();
            
            for i = 1:length(support)
                mapS(num2str(Ck(i,:))) = support(i);
            end
            
            S = [S; mapS];
        else
            break;
        end
        
        % 存储k-项频繁项目集
        if ~isempty(Fk)
            F(k).freqSets = Fk;
            k = k + 1;
        else
            break;
        end
    end
    
