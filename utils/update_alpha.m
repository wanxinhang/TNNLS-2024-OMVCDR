function [cnt1,alpha] = update_alpha(alpha1,H,X,Z)
%UPDATE_ALPHA 此处显示有关此函数的摘要
%   此处显示详细说明
% alpha1
num_p=size(H,1);
num_view = size(H,2);
tmp = zeros(num_p,1);
for p=1:num_p
    for v=1:num_view
        tmp(p) = tmp(p)+norm(X{v}-H{p,v}*Z{p},'fro')^2;
    end
end
cnt1=tmp;
tmp = ones(num_p,1)./sqrt(tmp);
total = 0;
for p=1:num_p
    total = total+tmp(p);
end
alpha = tmp/total;

end

