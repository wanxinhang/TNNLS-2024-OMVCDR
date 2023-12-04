function [cnt2,beta] = update_beta(Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda)
%UPDATE_BETA 此处显示有关此函数的摘要
%   此处显示详细说明
num_p=size(Z,1);
tmp = zeros(num_p,1);
for p=1:num_p
    for k=1:num_cluster
        sample_in_cluster=find(indx==k);
        for n=1:length(sample_in_cluster)
            tmp(p)=tmp(p)+1/2*lambda*avg_sample{p}(k);
            tmp(p)=tmp(p)-lambda*avg_cluster{p}(k,:)*Z{p}(:,sample_in_cluster(n));
            tmp(p)=tmp(p)+1/2*lambda*cnt(k)*Z{p}(:,sample_in_cluster(n))'*Z{p}(:,sample_in_cluster(n));
        end
    end
end
cnt2=tmp;
tmp = ones(num_p,1)./sqrt(tmp);
total = 0;
for p=1:num_p
    total = total+tmp(p);
end
beta = tmp/total;
end

