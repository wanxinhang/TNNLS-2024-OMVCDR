function [indx,avg_sample,avg_cluster,cnt] = update_Y(Z,beta,indx,cnt,avg_cluster,avg_sample,num_cluster)
%UPDATE_Y 此处显示有关此函数的摘要
%   此处显示详细说明
num_p=size(Z,1);
num_smaple=size(Z{1},2);
indxx=indx;
iter=1;
flag=1;
while flag
    for n=1:num_smaple
        for p=1:num_p
            avg_cluster{p}(indx(n),:)=avg_cluster{p}(indx(n),:)-Z{p}(:,n)';
            avg_sample{p}(indx(n))=avg_sample{p}(indx(n))-Z{p}(:,n)'*Z{p}(:,n);
        end
        cnt(indx(n))=cnt(indx(n))-1;
        t=zeros(num_cluster,1);
        for k=1:num_cluster
            for p=1:num_p
                t(k)=t(k)+beta(p)^2*avg_sample{p}(k);
                t(k)=t(k)-beta(p)^2*2*avg_cluster{p}(k,:)*Z{p}(:,n);
                t(k)=t(k)+beta(p)^2*cnt(k)*Z{p}(:,n)'*Z{p}(:,n);
            end
        end
        which=find(t==min(t));
        real_which=which(1);
        for i=1:length(which)
            if(cnt(which(i))<cnt(real_which))
                real_which=which(i);
            end
        end
        
        indx(n)=real_which;
        for p=1:num_p
            avg_cluster{p}(indx(n),:)=avg_cluster{p}(indx(n),:)+Z{p}(:,n)';
            avg_sample{p}(indx(n))=avg_sample{p}(indx(n))+Z{p}(:,n)'*Z{p}(:,n);
        end
        cnt(indx(n))=cnt(indx(n))+1;
    end
    if indxx==indx
        flag=0;
    end
    indxx=indx;
end
end

