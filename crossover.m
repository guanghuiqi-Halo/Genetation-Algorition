%子程序：新种群交叉操作,函数名称存储为crossover.m
function [path_1_infor_1,path_1_infor_2]=crossover(father_1,father_2,transport_time,customer,number_of_car)
    global path_1_infor_1 ;
    global  path_1_infor_2 ;
    path_1_infor = father_1.infor;
    path_2_infor = father_2.infor;
    % 随机选取车辆，得到路径L1和L2
    a = false;
    vehicle_1 = 0;
    vehicle_2 = 0;
    while a == false
        aa =false;
        aaa = false;
        c_1 = 0;
        c_2 = 0;
        vehicle_1 = floor(rand(1,1) * (number_of_car-1) +1);
        c_1 = sum(ismember(path_1_infor(1,:),vehicle_1));
        if c_1 ~= 0
            aa = true;
        end
        vehicle_2 = floor(rand(1,1) * (number_of_car-1) +1);
        c_2 = sum(ismember(path_2_infor(1,:),vehicle_2));
        if c_2 ~= 0
            aaa = true;
        end
        a = aa && aaa;
    end 
    % 将父代中选取的路径的基因删除掉
    %将父代一中的vehicle_1的基因提取为
    L1 = path_1_infor( :,path_1_infor(1,:) == vehicle_1);
    L1(:,1) = [];
    %将父代2中的vehicle_2的基因提取
    L2 = path_2_infor( :,path_2_infor(1,:) == vehicle_2);
    L2(:,1) = [];
    %将父代一中的所对应的L2的基因删除
    for i = 1:size(L2,2)
        value =  L2(3,i);
        path_1_infor(: , path_1_infor(3,:) == value) = [];
    end
        %将父代二中的所对应的L1的基因删除
    for i = 1:size(L1,2)
            value =L1(3,i);
            path_2_infor(: , path_2_infor(3,:) == value) = [];
    end

    
    % 将路径L上的基因按照成本增长最小的原则依次插入到父代中
    %% 将路径L2上的基因按照成本增长最小的原则依次插入到父代1中
    
    nnew_path_1.infor = path_1_infor;
    nnew_path_1.cost = [];
    for j = 1 : size(L2,2)
        insert_L2 = L2(:,j);
        
        new_path_1 = nnew_path_1;
        nnew_path_1 = [];
        for i = 1 : size(new_path_1,2)
            
            for jj = 1 : size( new_path_1(i).infor,2)
                if jj == size(new_path_1(i).infor, 2)
                    nnew_path_1(end+1).infor = [new_path_1(i).infor(:,1:jj),insert_L2];
                    nnew_path_1(end).infor(1:2,end) = nnew_path_1(end).infor(1:2,end-1);
                else
                    insert_left = new_path_1(i).infor(:,1:jj);
                    insert_right = new_path_1(i).infor(:,jj+1:end);
                    nnew_path_1(end+1).infor = [insert_left,insert_L2,insert_right];
                    nnew_path_1(end).infor(1:2,jj+1) = nnew_path_1(end).infor(1:2,jj);
                end
                [~,total_cost] = calculate_cost(nnew_path_1(end).infor,transport_time,customer,number_of_car);
                nnew_path_1(end).cost = total_cost;
            end
        end
    end
    nnew_path_1;
    if isempty(nnew_path_1(1).cost)
        path_1_infor_1 = nnew_path_1.infor;
    else
        [~,index]=sort([nnew_path_1.cost],'ascend');
        most_new_path = nnew_path_1(index);
        path_1_infor_1 = most_new_path(1).infor;
    end

    %% 将路径L1上的基因按照成本增长最小的原则依次插入到父代2中n
    
    nnew_path_2.infor = path_2_infor;
    nnew_path_2.cost = [];
    for j = 1 : size(L1,2)
        insert_L1 = L1(:,j);
        
        new_path_2 = nnew_path_2;
        nnew_path_2 = [];
        for i = 1 : size(new_path_2,2)
            
            for jj = 1 : size( new_path_2(i).infor,2)
                if jj == size(new_path_2(i).infor, 2)
                    nnew_path_2(end+1).infor = [new_path_2(i).infor(:,1:jj),insert_L1];
                    nnew_path_2(end).infor(1:2,end) = nnew_path_2(end).infor(1:2,end-1);
                else
                    insert_left = new_path_2(i).infor(:,1:jj);
                    insert_right = new_path_2(i).infor(:,jj+1:end);
                    nnew_path_2(end+1).infor = [insert_left,insert_L1,insert_right];
                    nnew_path_2(end).infor(1:2,jj+1) = nnew_path_2(end).infor(1:2,jj);
                end
                [~,total_cost] = calculate_cost(nnew_path_2(end).infor,transport_time,customer,number_of_car);
                nnew_path_2(end).cost = total_cost;
            end
        end
    end
    nnew_path_2;
    if isempty( nnew_path_2(1).cost)
        path_1_infor_2 =  nnew_path_2.infor;
    else
        [~,index]=sort([nnew_path_2.cost],'ascend');
        most_new_path = nnew_path_2(index);
        path_1_infor_2 = most_new_path(1).infor;
    end
 
   
   
   
   
   
   