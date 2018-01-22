% 此处引入一个计算成本的函数,返回带有总值的路径和总成本
function [path_cost,total_cost] = calculate_cost(path_infor,transport_time,customer,number_of_car)
transport_cost = 0;
date_cost = 0;
date(number_of_car) = 0;
for j = 1 : size(path_infor,2)-1

    % 取出i到j的客户名字
    customer_i = path_infor(3,j);
    customer_j = path_infor(3,j+1);
    %为其配送的车辆的编号
    num = path_infor(1,j+1);
    if customer_j == 0
        continue;
    else
        quntity_demand = customer(2,customer_j);
        transport_cost = transport_cost + quntity_demand * path_infor(2,j +1);
        early_date = customer(3,customer_j);
        lately_date = customer(4,customer_j);
        date(num) = date(num) + transport_time(customer_i+1,customer_j+1);
        if date(num) < early_date
            date_cost = date_cost + quntity_demand * 0.44 / 1000 *(early_date - date(num));
        end
        if date(num) > lately_date
             date_cost = date_cost + (date(num) - lately_date) * 4000;
        end
    end

    path_infor(4,j+1) = lately_date +date_cost;
end
path_cost = path_infor;
total_cost = transport_cost+date_cost;