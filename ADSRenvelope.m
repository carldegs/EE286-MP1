
function [t,y] = ADSRenvelope(a,d,s,r,pressed,fs)
    attack = 0:1/fs/a:1; % linear increase to 100%
    decay = 1+s*exp(d)*(exp(-1*(0:1/fs:d))-1);  % exponential decay
    sustain = ones(1, round((pressed-a-d)/fs))*s; % sustain  
    release = exp(-(0:1/fs:r))+s;
    y=[attack, decay, sustain, release];
    t=linspace(0, length(y)/fs, length(y));
end