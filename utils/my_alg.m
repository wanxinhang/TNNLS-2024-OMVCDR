function [indx,obj,beta] = my_alg(X,num_p,num_cluster,lambda,indx)
%MY_ALG 此处显示有关此函数的摘要
%   此处显示详细说明
maxIter=100;
num_view = length(X);
num_smaple=size(X{1},2);

%initialize A,Z,P of each view as 'identity matrix'
%conduct k-means of the first view to initialize Y
H=cell(num_p,num_view);
Z=cell(num_p,1);
avg_cluster=cell(num_p,1);
avg_sample=cell(num_p,1);
cnt=zeros(num_cluster,1);%num of samples in each cluster
alpha = ones(num_p,1)/num_p;
beta = ones(num_p,1)/num_p;
for p=1:num_p
    avg_cluster{p}=zeros(num_cluster,num_cluster*p);%calculate the sum of samples in the same cluster of each M
    avg_sample{p}=zeros(num_cluster,1);
    Z{p}=zeros(num_cluster*p,num_smaple);
    for v=1:num_view
        dim=size(X{v},1);
        H{p,v}=zeros(dim,num_cluster*p);
        if dim>=num_cluster*p
            for i=1:num_cluster*p
                H{p,v}(i,i)=1;
            end
        else
            for i=1:dim
                H{p,v}(i,i)=1;
            end
        end
    end
end

%initialize Y
% [indx,~,~] = kmeans(X{1}',num_cluster);
% end
flag = 1;
iter = 0;
while flag
    iter=iter+1
    if iter==1
        for n=1:num_smaple
            cnt(indx(n))=cnt(indx(n))+1;
        end
    end
    
    [Z,avg_cluster,avg_sample]=update_Z(H,X,Z,alpha,beta,indx,cnt,avg_cluster,avg_sample,lambda);
%     [cnt1]=update_alpha(alpha,H,X,Z);
%     [cnt2]=update_beta(beta,Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
%     [cnt1]=update_alpha(alpha,H,X,Z);
%     [cnt2]=update_beta(beta,Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
    
    
    H=update_H(H,X,Z);
%     [cnt1]=update_alpha(alpha,H,X,Z);
%     [cnt2]=update_beta(beta,Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
%     [cnt1]=update_alpha(alpha,H,X,Z);
%     [cnt2]=update_beta(beta,Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
    
    [indx,avg_sample,avg_cluster,cnt]=update_Y(Z,beta,indx,cnt,avg_cluster,avg_sample,num_cluster);
%     [cnt1]=update_alpha(alpha,H,X,Z);
%     [cnt2]=update_beta(beta,Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
%     [cnt1]=update_alpha(alpha,H,X,Z);
%     [cnt2]=update_beta(beta,Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
    
    
    [cnt1]=update_alpha(alpha,H,X,Z);
    [cnt2,beta]=update_beta(Z,indx,cnt,avg_cluster,avg_sample,num_cluster,lambda);
%     cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p)
    obj(iter) = cal_obj(cnt1,cnt2,alpha,beta,lambda,num_p);
    if (iter>2) && obj(iter)>obj(iter-1)
        error('wrong');
    end
    if (iter>2) && (abs((obj(iter)-obj(iter-1))/(obj(iter)))<1e-5 || iter>maxIter)
        flag =0;
    end
    
end
end

