function [Z,avg_cluster,avg_sample] = update_Z(H,X,Z,alpha,beta,indx,cnt,avg_cluster,avg_sample,lambda)
%UPDATE_Z 此处显示有关此函数的摘要
%   此处显示详细说明
num_p = size(H,1);
num_view = size(H,2);
num_smaple=size(X{1},2);
for p=1:num_p
    tmp1=H{p,1}'*X{1};
    for v=2:num_view
        tmp1=tmp1+H{p,v}'*X{v};
    end
    tmp1=tmp1*alpha(p)^2;
    for n=1:num_smaple
        %         tmpp1=Z{p}(:,n)';
        %         tmpp2=Z{p}(:,n)'*Z{p}(:,n);
        avg_cluster{p}(indx(n),:)=avg_cluster{p}(indx(n),:)-Z{p}(:,n)';
        avg_sample{p}(indx(n))=avg_sample{p}(indx(n))-Z{p}(:,n)'*Z{p}(:,n);
        Z{p}(:,n)=(lambda*beta(p)^2*avg_cluster{p}(indx(n),:)'+tmp1(:,n))/(alpha(p)^2*num_view+lambda*beta(p)^2*(cnt(indx(n))-1));
        avg_cluster{p}(indx(n),:)=avg_cluster{p}(indx(n),:)+Z{p}(:,n)';
        avg_sample{p}(indx(n))=avg_sample{p}(indx(n))+Z{p}(:,n)'*Z{p}(:,n);
    end
end
end

