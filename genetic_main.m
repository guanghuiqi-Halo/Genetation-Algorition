clear;
clc;
transport_time = [0,2,3,2,3,3,3,4,4,5,3;...
    2,0,3,3,2,2,3,3,5,5,3;...
    3,3,0,4,3,2,1,2,4,3,2;...
    2,3,4,0,4,4,5,5,6,6,4;...
    3,2,3,4,0,2,2,3,5,5,2;...
    3,2,2,4,2,0,2,2,5,5,1;...
    3,3,1,5,2,2,0,1,4,4,1;...
    4,3,2,5,3,2,1,0,5,3,1;...
    4,5,4,6,5,5,4,5,0,5,5;...
    5,5,3,6,5,5,4,3,5,0,4;...
    3,3,2,4,2,1,1,1,5,4,0]; % 物流企业间运输时间表


customers_demand =[1,2,3,4,5,6,7,8,9,10;3000,10000,5000,2000,2000,10000,8000,5000,7000,20000]; % 客户对货物的需求量
customers_time = [1,2;2,4;3,5;4,8;3,10;11,15;3,6;7,12;4,10;2,7]'; % 客户对运输过程的时间窗约束
customer = [customers_demand;customers_time];   %客户的基本信息（客户编号，需求量，时间窗约束）

num_of_vehicles = [1,2,3,4,5,6,7]; %车辆那个编号
situation_of_vehicles = [15000,15000,2000,25000,25000,40000,40000];%物流企业货车载重情况表
time_of_vehicles = ones(1,7)*30; %车辆的最大运输时间
vehicle = [num_of_vehicles;situation_of_vehicles;time_of_vehicles];%第一行为车辆编号，第二行为载重，第三行为剩余时间

number_of_car = size(num_of_vehicles,2); %拥有汽车数量
cost_sortage = 0.44; % 每吨的早送到的每天储存成本
deadline_cost = 4000; % 延迟送到的延误成本，单位每天


espo = 50  ;  %种群数量
popsize = espo;
Generationnmax=3;  %最大代数

%% 产生初始种群,返回的select为车辆路径、车辆编号、单位运费的结构体
path = initialization(transport_time,customer,vehicle,espo);


%% 计算适应度,返回适应度Fitvalue和累积概率cumsump
new_path =fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car) ;
%% 
Generation=1;
while Generation < Generationnmax+1
   for j=1:2:popsize
      %选择操作
      [father_1,father_2] = selection(new_path);
      %交叉操作
      [path_1_infor_1,path_1_infor_2]=crossover(father_1,father_2,transport_time,customer,number_of_car);
      %变异操作
      snnew_1=mutation(path_1_infor_1,transport_time,number_of_car,vehicle,customer);
      new_f(j).infor = snnew_1;
      snnew_2=mutation(path_1_infor_2,transport_time,number_of_car,vehicle,customer);
      new_f(j+1).infor = snnew_2;
      j
   end
   path = new_f;  %产生了新的种群 
   %计算新种群的适应度   
   new_path = fitnessfun(path,transport_time,customer,cost_sortage,deadline_cost,number_of_car)
   %记录当前代最好的适应度和平均适应度
   Generation = Generation+1
end
new_path