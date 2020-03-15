function sound = play_sound(num, play)
if nargin < 2
    play = 0;
end
fs = 1000;
t = (1:2500)/fs;
c = 261.63;
d = 293.66;
e = 329.63;
f = 349.23;
g = 392.00;
a = 440.00;
switch num
    case 1
        s = c;
    case 2
        s = d;
    case 3
        s = e;
    case 4
        s = f;
    case 5
        s = g;
    case 6 
        s = a;
end
sound = sin(2*s*pi*t);
sound = [sound, zeros(1,800)];
if play  == 1
    soundsc(sound);
end

        