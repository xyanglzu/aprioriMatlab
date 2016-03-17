% apriori算法的实现
% 输入：filename -- 要录入数据的文件名
%      minSup   -- 最小支持度
%      minConf  -- 最小置信度
% 输出：rules    -- 生成的规则集

function rules = apriori(filename, minSup, minConf)

    % 将文件的数据每行作为一个cell放入transactions变量中
    transactions = loadData(filename);
    % 从事务数据中寻找频繁项集
    [F, S, ~] = findFreqItemsets(transactions, minSup);

    fprintf('最小支持度为：%d\n', minSup);
    fprintf('频繁项集有: %d\n', sum(arrayfun(@(x) size(x.freqSets,1), F)))
    fprintf('最大维度为：k = %d\n', length(F))

    % 根据得到的频繁项集及其支持度，计算符合最小置信度的规则
    rules = generateRules(F, S, minConf);
    fprintf('最小置信度为：%d\n', minConf);
    fprintf('找到%d条规则\n', length(rules));

    % 规则中所有存在的结点
    nodes = unique([[rules.Condition],[rules.Consequence]]);

    % 创建规则的邻接矩阵
    AdjMat = zeros(length(nodes));
    for i = 1:length(rules)
        for j = 1:length(rules(i).Condition)
            for k = 1:length(rules(i).Consequence)
                source = rules(i).Condition(j);
                target = rules(i).Consequence(k);
                AdjMat(nodes == source,nodes == target) =...
                    AdjMat(nodes == source,nodes == target) + 1;
            end
        end
    end

    % 将结点每个元素转换成cell数组
    ids = arrayfun(@(x) num2str(x), nodes,'UniformOutput',false);
    % 将该邻接矩阵以图的形式表示
    graph = biograph(AdjMat,ids,'ShowWeights','on');
    dolayout(graph);
    view(graph)

end
