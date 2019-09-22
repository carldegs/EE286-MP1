
function [a,d,s,r, t, P, sDuration] = getADSR(x, fs)
    L = floor(fs*0.02); % 20ms windows
    [t,P] = intensityContour(x,fs,L);
    K=length(P);
    pdiff=diff(10*log10(P)); %% get the decibel diff

    %% We assume that the only rise is in the beginning from t0 up to attack end, where it is the maximum value
    a_start = find(pdiff>5,1); 
    if isempty(a_start)
        a_start = 1;
    end
    a_end = find(P==max(P));
    if isempty(a_end(a_end >= a_start))
        a = t(a_end);
    else
        a_end = a_end(a_end>=a_start);
        a=t(a_end(1))-t(a_start(1));
    end
    
    %% Get decay end
    for decay_end=a_end:length(pdiff)
        if pdiff(decay_end) > 0
            break
        end
    end

    d = t(decay_end) - t(a_end);
    
    %% If pdiff does not go below 0.5 dB, we are still within the sustain level
    for s_end=decay_end:length(pdiff)
        if pdiff(s_end) < -0.5
            break
        end
    end
    sDuration = t(s_end)-t(decay_end);
    
    %% Let's say the sustain level is the average power level between decay_end and sustain end
    s = mean(P(decay_end:s_end));
    
    %% End the decay when we reach -40 dB from sustain or 0.01
    r_end = find(P < 0.01*s,1);
    if isempty(r_end) || isempty(r_end(r_end>s_end))
        r = t(K)-t(s_end);
    else
        r_end=r_end(r_end>s_end);
        r = t(r_end(1))-t(s_end);
    end
end

function [t,P] = intensityContour(x,fs, L)
    %% Plot the intensity contour of the wav file
    step=L; %hop size of segments in samples
    N=length(x); K=fix((N-L+step)/step);
    time=(1:L)';
    P=zeros(1,K);
    for k=1:K
        x_rms=rms(x(time));
        P(k)=x_rms; %get the power level
        time=time+step;
    end
    t=linspace(0,N/fs,K); %assign x-axis values
    P=P/max(P); % normalize the intensity
end
