function y = karplus_strong_drum(adsr_envelope, fs, D, p) 
    N = length(adsr_envelope);

    %% Generate wavetable
    wavetable = ones(1,D);
    fig=figure();
    
    y = zeros(1,N); % initialize output vector
    current_sample = 1;

    figure(fig); subplot(3,1,1);plot(wavetable);set(gca,'fontsize',18);
    title('Original wavetable');
    subplot(3,1,2);plot(wavetable);set(gca,'fontsize',18);
    
    %%
    % ******* Run Loop Start ******* %
    filtA=1;
    filtB=[0.5 0.5]*0.8;
    z=zeros(1, max(length(filtA), length(filtB)));
    
    filtA=1;
    filtB=0.9999999*[0.5 0.5];z=0;
    for n = 1:N
        y(n) = wavetable(current_sample);
        r = binornd(1,p);
        sign = (r == 1) * 2 - 1;
        [wavetable(current_sample), z]= filter(sign*filtB, filtA, y(n), z);

        % Increment Pointers & Check Limits
        current_sample = current_sample + 1;
        if current_sample  > D
            current_sample  = 1;
        end

        if mod(n,2000) == 0
            figure(fig);
            subplot(3,1,2);plot(wavetable)
            str = sprintf('Filter delayline step %d',n);
            title(str);
            subplot(3,1,3); plot(y);
            str = sprintf('Waveform Step %d',n);
            title(str);
        end
    end
    % Scale soundfile if necessary
    if max(abs(y)) > 0.95
        y = y./(max(abs(y))+0.1);
    end

    figure;
    clf;plot(y); title('Final Step');set(gca,'fontsize',18);
    y=y.*adsr_envelope;
end
    

%% Binomial distribution, n tries, probability p
function r=binornd(n, p)
        r = sum(rand([1,n]) < p);

end