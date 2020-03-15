eeglab;
fs = 250;
start = 20*fs+1;
trial = 10*ones(6,2);
%% load train data
%load('trial_num.mat');
stop = (20+10*trial)*fs;
d = [];
label = [];
for i = 1:6
    for j = 1:2
        if trial(i,j) == 0
            break
        end
        filename = strcat('trial',num2str(i),'-',num2str(j),'.txt');
        data = load(filename);
        [temp,~] = size(data);
        if stop(i,j) > temp
            data = [data; zeros(stop(i,j)-temp,12)];
        end
        data = data(start: stop(i,j), 2:8)';
        data = eegfilt(data,fs,1,50,0,0,0,'fir1');
        d = [d,data];
        label = [label; i*ones(trial(i,j),1)];
    end
end
%%
n = length(d)/10/fs;
%d = reshape(d,7,10*fs,n);
%d = d(:,(fs+1):fs*6,:);
%% load test data
trial = [10,11];
stop = (20+trial*10)*fs;
d = [];
for i = 1:2
    filename = strcat('test',num2str(i),'.txt');
    data = load(filename);
    [temp,~] = size(data);
    if stop > temp
        data = [data; zeros(stop(i)-temp,12)];
    end
    data = data(start: stop(i), 2:8)';
    data = eegfilt(data,fs,1,50,0,0,0,'fir1');
    d = [d,data];
end
n = length(d)/10/fs;
d = reshape(d,7,10*fs,n);
%d = d(:,(fs+1):fs*6,:);