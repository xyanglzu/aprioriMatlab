% 从数据集文件中读取数据
% 输入：filename     -- 文件名
% 输出：transactions -- 事务cell矩阵，每一行是一个事务中的项目集
%      items        -- 所有事务中所包含的不重复的项目ID

function transactions = loadData(filename)

    % 将文件的每一行以字符串形式存储在cell矩阵中
    fid = fopen(filename);
    lines = textscan(fid,'%s','delimiter','\n');
    lines = lines{1}; % 将cell数组降级
    fclose(fid);

    % 将每一行的cell矩阵转化成数字矩阵，并存储在transactions中
    transactions = cell(size(lines));

    for i = 1:length(lines)
        line = textscan(lines{i},'%d');
        transactions{i} = line{1}';
    end

end