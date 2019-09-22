function [a,d,s,r, P, t] = getADSR(x, fs)
    [t,P] = intensityContour(x,fs);
    a=0.1;d=0.1;s=0.5;r=0.1;
end

function [t,P] = intensityContour(x,fs)
    %% Plot the intensity contour of the wav file
    L = floor(fs*0.01); % compute segment size so that windows are 10ms
    step=L; %hop size of segments in samples
    N=length(x); K=fix((N-L+step)/step);
    time=(1:L)';
    P=zeros(1,K);
    for k=1:K
        x_rms=rms(x(time));
        P(k)=x_rms; %get the power level
        time=time+step;
    end
    t=linspace(0,L/fs*K,K); %assign x-axis values
end
