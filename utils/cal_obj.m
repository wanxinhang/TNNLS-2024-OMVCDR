function [obj] = cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
%CAL_OBJ 此处显示有关此函数的摘要
%   此处显示详细说明
obj=0;
for p=1:num_p
    obj=obj+alpha(p)^2*cnt1(p)+beta(p)^2*cnt2(p);
end
end

