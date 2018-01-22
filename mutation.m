%子程序：新种群变异操作，函数名称存储为mutation.m
function snnew=mutation(path_1_infor,transport_time,number_of_car,vehicle,customer)
length = size(path_1_infor,2);
a = true;
a_1 = 0;
a_2 = 0;
while a == true
    a_1 = floor(rand()*(length-1)+1);
    a_2 = floor(rand()*(length-1)+1);
    if path_1_infor(3,a_1)~=0 && path_1_infor(3,a_2)~=0 && path_1_infor(1,a_1) ~= path_1_infor(1,a_2)
        a = false;
    end
end
%取出基因位
Mp1 = path_1_infor(:,a_1);
Mp2 = path_1_infor(:,a_2);
Mp = Mp1;
Mp1(1:2,1) = Mp2(1:2,1);
Mp2(1:2,1) = Mp(1:2,1);




% 变异点1进入步骤2，进行交换操作
veh_1 = path_1_infor(1,a_1);
veh_1_infor = path_1_infor(:,path_1_infor(1,:)==veh_1);
vveh_1_infor = veh_1_infor;
vveh_1_infor(:,vveh_1_infor(3,:)==Mp1(3,1)) = Mp2;


if ~MP1MP2(vveh_1_infor,transport_time,number_of_car,vehicle,customer)
    %进入步骤三
    veh_1_infor(:,veh_1_infor(3,:)==Mp1(3,1)) = [];
    for j = 1:size(veh_1_infor,2)
        vveh_1_infor = veh_1_infor;
        if j < size(veh_1_infor,2)
            vveh_1_infor_left = vveh_1_infor(:,1:j);
            vveh_1_infor_right = vveh_1_infor(:,j+1:end);
            vveh_1_infor = [vveh_1_infor_left,Mp2,vveh_1_infor_right];
        else
            vveh_1_infor = [vveh_1_infor,Mp2];
        end
        if MP1MP2(vveh_1_infor,transport_time,number_of_car,vehicle,customer)
            break;
        end
    end
end
path_1_infor(:,path_1_infor(1,:) == veh_1 ) = vveh_1_infor;


% 变异点2进入步骤2，进行交换操作
veh_2 = path_1_infor(1,a_2);
veh_2_infor = path_1_infor(:,path_1_infor(1,:)==veh_2);
vveh_2_infor = veh_2_infor;
vveh_2_infor(:,vveh_2_infor(3,:) == Mp2(3,1)) = Mp1;

if ~MP1MP2(vveh_2_infor,transport_time,number_of_car,vehicle,customer)
    %进入步骤三
    veh_2_infor(:,veh_2_infor(3,:)==Mp2(3,1)) = [];
    for j = 1:size(veh_2_infor,2)-1
        vveh_2_infor = veh_2_infor;
        if j < size(veh_2_infor,2)
            vveh_2_infor_left = vveh_2_infor(:,1:j);
            vveh_2_infor_right = vveh_2_infor(:,j+1:end);
            vveh_2_infor = [vveh_2_infor_left,Mp1,vveh_2_infor_right];
        else
            vveh_2_infor = [vveh_2_infor,Mp1];
        end
        if MP1MP2(vveh_2_infor,transport_time,number_of_car,vehicle,customer);
            break;
        end
    end
end
path_1_infor(:,path_1_infor(1,:) == veh_2 ) = vveh_2_infor;
snnew = path_1_infor;