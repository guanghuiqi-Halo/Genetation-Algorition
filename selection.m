%子程序：新种群选择操作, 函数名称存储为selection.m
function [father_1,father_2]=selection(new_path)
%从种群中选择两个个体
a = false;
father_num = 0; %初始化父代数量
father_1 = [];
father_2 = [];% 初始化父代
while a == false
    r = floor(rand * 49 + 1); 
    if new_path(r).series == 0;
        if father_num == 0
            father_1 = new_path(r);
            father_num = father_num + 1;
        elseif father_num == 1
            father_2 = new_path(r);
            a = true;
         end
    end
end
