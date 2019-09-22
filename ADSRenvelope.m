function [t,y] = ADSRenvelope(a,d,s,r,pressed,fs)
    attack = 0:1/fs/a:1; % linear increase to 100%
    attack=1-exp(log(0.001)/a*(0:1/fs/a:1));
    decay = exp(log(s)/d*(0:1/fs:d));  % exponential decay
    sustain = ones(1, round((pressed-a-d)*fs))*s; % sustain  
    release = s*exp(log(0.01*s)/r*(0:1/fs:r)) ; % decay to 40db
    y=[attack, decay, sustain, release];
    t=linspace(0, length(y)/fs, length(y));
end
 