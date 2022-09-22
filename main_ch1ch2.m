close all;

[data,namelist] = data_merge('*.Wfm.csv',1,1);

all_mean=[];
for i=1:size(data,2)
    mean_cal=mean(data(:,i));
%     figure;plot(data(:,i));
    all_mean=[all_mean mean_cal];
end

[data2,namelist2] = data_merge('*.Wfm.csv',2,1);

all_mean2=[];
for j=1:size(data2,2)
    mean_cal2=mean(data2(:,j));
%     figure;plot(data(:,i));
    all_mean2=[all_mean2 mean_cal2];
end


data1=[data(:,11:20),data(:,22:26),data(:,21)];
data_2=[data2(:,11:20),data2(:,22:26),data2(:,21)];


[dist_mid1,ssim_mid1,dist_all1,ssim_all1,all_data1]=data_preprocessing_for_cluster(data1);
[dist_mid2,ssim_mid2,dist_all2,ssim_all2,all_data2]=data_preprocessing_for_cluster(data_2);



%plot
for j=1:size(all_data1,2)
    figure;plot(all_data1(:,j));ylim([0 1]);
end
for j=1:size(all_data2,2)
    figure;plot(all_data2(:,j));ylim([0 1]);
end

% X=[dist_all1(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
X=[dist_all1(1,1:size(dist_all1,2)-1)',dist_all2(1,1:size(dist_all2,2)-1)'];
% X=[ssim_all1(1,1:size(ssim_all1,2)-1)',zeros(9size(ssim_all1,2)-1,1)];
[idx,C] = kmeans(X,3);
figure;
gscatter(X(:,1),X(:,2),idx,'bgm');
xlabel('CH1');
ylabel('CH2');
hold on
plot(C(:,1),C(:,2),'kx');
legend('Cluster 1','Cluster 2','Cluster 3','Cluster Centroid');
% 
% Xtest=[dist_all2(1,1:size(dist_all2,2)-1)',ssim_all2(1,1:size(ssim_all2,2)-1)'];
% % Xtest=[dist_all2(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
% [~,idx_test] = pdist2(C,Xtest,'euclidean','Smallest',1);
% gscatter(Xtest(:,1),Xtest(:,2),idx_test,'bgm','+++');
% 
% Xtest2=[dist_all3(1,1:size(dist_all3,2)-1)',ssim_all3(1,1:size(ssim_all3,2)-1)'];
% % Xtest=[dist_all2(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
% [~,idx_test2] = pdist2(C,Xtest2,'euclidean','Smallest',1);
% gscatter(Xtest2(:,1),Xtest2(:,2),idx_test2,'bgm','***');
% 
% Xtest3=[dist_all4(1,1:size(dist_all4,2)-1)',ssim_all4(1,1:size(ssim_all4,2)-1)'];
% % Xtest=[dist_all2(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
% [~,idx_test3] = pdist2(C,Xtest3,'euclidean','Smallest',1);
% gscatter(Xtest3(:,1),Xtest3(:,2),idx_test3,'bgm','ppp');
% 
% Xtest4=[dist_all5(1,1:size(dist_all5,2)-1)',ssim_all5(1,1:size(ssim_all5,2)-1)'];
% % Xtest=[dist_all2(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
% [~,idx_test4] = pdist2(C,Xtest4,'euclidean','Smallest',1);
% gscatter(Xtest4(:,1),Xtest4(:,2),idx_test4,'bgm','sss');
% 
% Xtest5=[dist_all6(1,1:size(dist_all6,2)-1)',ssim_all6(1,1:size(ssim_all6,2)-1)'];
% % Xtest=[dist_all2(1,1:size(dist_all1,2)-1)',zeros(size(dist_all1,2)-1,1)];
% [~,idx_test5] = pdist2(C,Xtest5,'euclidean','Smallest',1);
% gscatter(Xtest5(:,1),Xtest5(:,2),idx_test,'bgm','ddd');

% legend('Cluster 1(C-X)','Cluster 2(C-X)','Cluster 3(C-X)','Cluster Centroid', ...
%     'Data classified to Cluster 1(C-Y)','Data classified to Cluster 2(C-Y)', ...
%     'Data classified to Cluster 3(C-Y)', ...
%     'Data classified to Cluster 1(C-Z)','Data classified to Cluster 2(C-Z)', ...
%     'Data classified to Cluster 3(C-Z)', ...
%     'Data classified to Cluster 1(M-X)','Data classified to Cluster 2(M-X)', ...
%     'Data classified to Cluster 3(M-X)', ...
%     'Data classified to Cluster 1(M-Y)','Data classified to Cluster 2(M-Y)', ...
%     'Data classified to Cluster 3(M-Y)', ...
%     'Data classified to Cluster 1(M-Z)','Data classified to Cluster 2(M-Z)', ...
%     'Data classified to Cluster 3(M-Z)');
