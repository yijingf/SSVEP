function s = sequence(f, phase)
t = mod(60,f);
if t == 0
    seq = 30/f*ones(1,f*2);
else
    switch (f)
        case 9
            s1 = repmat([3 4 3], 1, 2);
            s2 = repmat([4 3 3], 1, 2);
            s3 = repmat([3 3 4], 1, 2);
            seq = [s1 s2 s2];
        case 11 
            seq = [3 3 2 3 3 3 2 3 3 3 2 3 3 2 3 3 3 2 3 3 3 2];
        case 13 
            seq = [2 2 3 2 2 3 2 2 3 2 2 3 2 2 3 2 2 3 2 2 3 2 2 3 2 2];
    end
end
for i = 2:length(seq)
    seq(i) = seq(i-1)+seq(i);
end
interval = zeros(2,length(seq)/2+1);
i=1:length(seq)/2;
interval(2,i) = seq((i-1)*2+1);
interval(1,i+1) = seq(i*2);
s = zeros(1,60);
for i = 1:length(interval)
    for j = interval(1,i)+1:interval(2,i)
        s(j) = 1;
    end
end
start = round(phase*60/f);
s_phase = [s(start+1:end), s(1:start)];
s = s_phase;