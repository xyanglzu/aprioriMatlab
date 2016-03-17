% apriori�㷨��ʵ��
% ���룺filename -- Ҫ¼�����ݵ��ļ���
%      minSup   -- ��С֧�ֶ�
%      minConf  -- ��С���Ŷ�
% �����rules    -- ���ɵĹ���

function rules = apriori(filename, minSup, minConf)

    % ���ļ�������ÿ����Ϊһ��cell����transactions������
    transactions = loadData(filename);
    % ������������Ѱ��Ƶ���
    [F, S, ~] = findFreqItemsets(transactions, minSup);

    fprintf('��С֧�ֶ�Ϊ��%d\n', minSup);
    fprintf('Ƶ�����: %d\n', sum(arrayfun(@(x) size(x.freqSets,1), F)))
    fprintf('���ά��Ϊ��k = %d\n', length(F))

    % ���ݵõ���Ƶ�������֧�ֶȣ����������С���ŶȵĹ���
    rules = generateRules(F, S, minConf);
    fprintf('��С���Ŷ�Ϊ��%d\n', minConf);
    fprintf('�ҵ�%d������\n', length(rules));

    % ���������д��ڵĽ��
    nodes = unique([[rules.Condition],[rules.Consequence]]);

    % ����������ڽӾ���
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

    % �����ÿ��Ԫ��ת����cell����
    ids = arrayfun(@(x) num2str(x), nodes,'UniformOutput',false);
    % �����ڽӾ�����ͼ����ʽ��ʾ
    graph = biograph(AdjMat,ids,'ShowWeights','on');
    dolayout(graph);
    view(graph)

end
