clear all
%cca-cv
load('sub2_train_data.mat')
N = length(labels);
n_target = 6;
nh = 6;%number of harmonics
fs = 250;
time = round((1*fs+1)):round(5*fs);
data = data(:,time,:);
f = [9,11,13,10,12,15];
[ch,L,~] = size(data);
num = 1:N;

% reference signal
y = nan(2*nh, L, n_target);
for i = 1:n_target
    y(:,:,i) = refer(L, f(i), fs, nh);
end

%% cross-validation on training set
k_fold = 80;
Indices = crossvalind('Kfold', N, k_fold);
corr_coef_cv = nan(N,n_target);
for i = 1:k_fold
    test = find(Indices == i);
    train = setdiff(num, test);
    traindata = data(:,:,train);
    testdata = data(:,:,test);
    trainlabel = labels(train);
    tr_ref = nan(ch,L,n_target);%initialize train reference matrix
    for j = 1:6
        temp = find(trainlabel == j);
        tr_ref(:,:,j) = mean(traindata(:,:,temp),3);
    end
    for k = 1:length(test)
        corr_coef_cv(test(k),:) = corr_cca(tr_ref, testdata(:,:,k), y, n_target);
    end
end
[~,in_cv] = max(corr_coef_cv,[],2);
acc = length(find(in_cv - labels == 0));
acc
%% threshold
tr_ref = nan(ch,L,n_target);
l = {};
%miss = [];
%labels1(miss) = [];
for i = 1:6
    temp = find(labels == i);
    tr_ref(:,:,i) = mean(data(:,:,temp),3);
    l{i} = temp;
end
corr_coef_tr = nan(N,n_target);
for i = 1:N
    corr_coef_tr(i,:) = corr_cca(tr_ref, data(:,:,i), y, n_target);
end
c = zeros(N,n_target);
threshold = zeros(1,n_target);
for i = 1:n_target
    c(l{i},i) = corr_coef_tr(l{i},i);
    s = nonzeros(c(:,i));
    threshold(i) = mean(s) - 1.5*std(s);
end
[~,in_tr] = max(corr_coef_tr,[],2);
length(find(in_tr - labels == 0))
% %% test
load('music.mat')
test_data = test_data(:,time,:);
corr_coef_te = nan(length(test_labels),n_target);
for i = 1:length(test_labels)
    corr_coef_te(i,:) = corr_cca(tr_ref, test_data(:,:,i), y, n_target);
end
[~,in_te] = max(corr_coef_te,[],2);
length(find(in_te - test_labels == 0))
% %% rest
% load('rest_train.mat')
% test_data = rest(:,time,:);
% corr_coef = nan(120,n_target);
% for i = 1:120
%     corr_coef(i,:) = corr_cca(tr_ref, test_data(:,:,i), y, n_target);
% end
% %[~,in_te] = max(corr_coef,[],2);
% %length(find(in_te - test_labels == 0))