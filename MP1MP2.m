function isok = MP1MP2(Path,transport_time,number_of_car,vehicle,customer)
time(number_of_car) = 0;
gross_veh(number_of_car) = 0;
for j = 1 : size(Path,2)-1
    customer_i = Path(3,j);
    customer_j = Path(3,j+1);
    num = Path(1,j);
    if customer_j == 0
        time(num) = time(num) + transport_time(customer_i + 1,customer_j + 1);
        continue;
    else
        time(num) = time(num) + transport_time(customer_i+1,customer_j+1);
        gross_veh(num) = gross_veh(num) + customer(2,customer_j);
    end
end
a = sum(time > 30);
b = sum(gross_veh >  vehicle(2,:));
if a+b>=1
    isok = false;
else
    isok = true;
end
    