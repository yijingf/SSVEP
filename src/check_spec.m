figure
ff = [9,11,13];
for j = 1:3
    s = sequence(ff(j),0);
    Fs = 60;
    L = 1000;
    i = 1;
    signal = zeros(1,L);
    while i <= L
        n = mod(i,60)+1;
        signal(i) = s(n);
        i = i+1;
    end
    N = 2^nextpow2(L);
    y = fft(signal, N)/L;
    f = Fs/2*linspace(0, 1, N/2+1);
    
    subplot(1,3,j)
    plot(f,2*abs(y(1:N/2+1)))
    title_p = strcat(num2str(ff(j)),'Hz')
    title(title_p)
end