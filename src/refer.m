function y = refer(L, f, fs, nh)
t = (0:L-1)/fs;
y = nan(nh*2,L);
for i = 1:nh
    y((i-1)*2+1,:) = sin(2*pi*f*i*t);
    y(i*2,:) = cos(2*pi*f*i*t);
end
