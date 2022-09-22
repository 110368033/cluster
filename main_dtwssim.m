close all;

[data,namelist] = data_merge('*.Wfm.csv',1,1);

all_mean=[];
for i=1:size(data,2)
    mean_cal=mean(data(:,i));
%     figure;plot(data(:,i));
    all_mean=[all_mean mean_cal];
end

% min_=min(all_mean);
% max_=max(all_mean);

data1=[data(:,21:37),data(:,39:40),data(:,38)];
% data1=[data(:,21:29),data(:,39)];
data2=[data(:,1:20),data(:,38)];

[dist_mid1,ssim_mid1,dist_all1,ssim_all1,all_data1]=data_preprocessing_for_cluster(data1);
[dist_mid2,ssim_mid2,dist_all2,ssim_all2,all_data2]=data_preprocessing_for_cluster(data2);

for j=1:size(all_data1,2)
    figure;plot(all_data1(:,j));ylim([-1 1]);
end
for j=1:size(all_data2,2)
    figure;plot(all_data2(:,j));ylim([-1 1]);
end
% X=[dist_all1(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
X=[dist_all1(1,1:size(dist_all1,2)-1)',ssim_all1(1,1:size(ssim_all1,2)-1)'];
% X=[ssim_all1(1,1:size(ssim_all1,2)-1)',zeros(9size(ssim_all1,2)-1,1)];
[idx,C] = kmeans(X,3);
figure;
gscatter(X(:,1),X(:,2),idx,'bgm');
xlabel('DTW');
ylabel('SSIM');
hold on
plot(C(:,1),C(:,2),'kx');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid');
% 
Xtest=[dist_all2(1,1:size(dist_all2,2)-1)',ssim_all2(1,1:size(ssim_all2,2)-1)'];
% Xtest=[dist_all2(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
[~,idx_test] = pdist2(C,Xtest,'euclidean','Smallest',1);
gscatter(Xtest(:,1),Xtest(:,2),idx_test,'bgm','ooo');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid', ...
    'Data classified to Cluster 1','Data classified to Cluster 2', ...
    'Data classified to Cluster 3');
