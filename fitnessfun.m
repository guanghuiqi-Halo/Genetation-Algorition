%子程序：计算适应度函数, 函数名称存储为fitnessfun
function new_path =fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car)

%number_of_car = size(num_of_vehicles,2) %拥有汽车数量
% cost_sortage = 0.44; % 每吨的早送到的每天储存成本
% deadline_cost = 4000; % 延迟送到的延误成本，单位每天



% 计算每个个体所对应的运输成本
for i = 1:size(path,2)
    date_cost = 0;
    date =zeros(1,number_of_car);
    transport_cost = 0; %一个个体将的所有成本归零，日期成本和运输成本

    for j = 1:size(path(i).infor,2)-1
        %进行取值，num_veh为配送的车辆编号，num_cost为单为运输成本customer_i-->j的路径
        num_veh = path(i).infor(1,j);
        num_cost = path(i).infor(2,j);
        customer_i = path(i).infor(3,j);
        customer_j = path(i).infor(3,j + 1);
        %计算运输成本，不考虑时间窗
        if customer_j == 0
            continue
        else
            customer_demand = customer(2,customer_j);
            transport_cost = transport_cost + num_cost * customer_demand;
            eary_date = customer(3,customer_j);
            deadline_date = customer(4,customer_j);
            date(num_veh) = date(num_veh) + transport_time(customer_i + 1,customer_j + 1);
            % 计算早到的成本
            if date(num_veh) < eary_date
                date_cost = date_cost + (eary_date - date(num_veh)) * customer_demand / 1000 * cost_sortage;
            end
            % 计算晚到的成本
            if date(num_veh) > deadline_date
                date_cost = date_cost + (date(num_veh) - deadline_date) * deadline_cost;
            end
        end
    end
   for x = 1:size(path(i).infor,2)-1
        xx = path(i).infor(3,x);
        yy = path(i).infor(3,x+1);
        a =[];
        a(1,size(path(i).infor,2)) = 0;
        if xx == 0 && yy == 0
            a(1,x) = path(i).infor(1,x);
        end
    end
    path(i).infor(:,path(i).infor(1,:) == a ) = [];
    N = numel(find(path(i).infor ==0 )); % 一个个体中的车辆数量
    path(i).cost = date_cost + transport_cost;
    path(i).Num = N;
end
%% 计算每一个个体的序 
for i = 1:size(path,2)
   cost_total = path(i).cost;
   num_total = path(i).Num;
   path(i).series = 0;
   for j = 1:size(path,2)
       if cost_total > path(j).cost && num_total > path(j).Num
           path(i).series = path(i).series + 1;
       end
   end
end
[~,index]=sort([path.series],'ascend');
new_path = path(index);


%% 计算个体分配的选择概率，最好为1，最差为0.公式见论文
q = 1;
q0 = 0;
path_size = size(new_path,2);
r = path_size;
f = (q - q0)/r;
for i = 1 : path_size
    p = q-(i -1)*f;
    new_path(i).choice = p;
end










