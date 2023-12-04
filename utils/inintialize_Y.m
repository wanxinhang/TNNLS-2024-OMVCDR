function [Y] = inintialize_Y(X,k)
%ININTIALIZE_Y 此处显示有关此函数的摘要
%   此处显示详细说明
num_view=size(X,1);
% XX=cell(num_view,1);
% U = cell(num_view,1);
% V = cell(num_view,1);
% for v=1:num_view
%     [U{v},~,V{v}] = svd(X{v}','econ');
%     XX{v} = U{v}*V{v}';
% end
M=X{1}';
for v=2:num_view
    %         X{v} = zscore(X{v})';
    M=[M,X{v}'];
end
S=sum(M,2);
SS=S;
which=zeros(k,1);
% size(which)
for cnt=1:k
    [value,where]=max(SS);
    SS=SS/value;
    which(cnt)=where;
    for n=1:size(SS,1)
        SS(n)=SS(n)*(1-SS(n));
    end
end
Y=kmeans(M,k,'Start',M(which,:));
end

