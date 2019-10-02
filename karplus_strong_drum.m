function y = karplus_strong_drum(adsr_envelope, fs, D, p, stretch_factor, wave_type) 
    N = length(adsr_envelope);
    y = zeros(1,N); % initialize output vector

    %% Generate wavetable
    if strcmp(wave_type, 'dc') == 0
        wavetable = ones(1, length(adsr_envelope));
    elseif strcmp(wave_type, 'fm') == 0
        wavetable = fm_synthesis(adsr_envelope, fs, 180, 40,20);
    else
        return 
    end
        
    fig=figure();
    
    current_sample = 1;

    figure(fig); subplot(3,1,1);plot(wavetable);set(gca,'fontsize',18);
    title('Original wavetable');
    subplot(3,1,2);plot(wavetable);set(gca,'fontsize',18);
    
    %%
    % ******* Run Loop Start ******* %
  
    filtA=1;
    filtB=0.9999999*[0.5 0.5];z=0;
    for n = 1:N
        y(n) = wavetable(current_sample);
        
        skip = binornd(1, 1-1/stretch_factor);
        if skip == 0
            r = binornd(1,p);
            sign = (r == 1) * 2 - 1;
            [wavetable(current_sample), z]= filter(sign*filtB, filtA, y(n), z);            
        end
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
    if max(abs(y)) > 0.95
        y = y./(max(abs(y))+0.1);
        disp('Scaled waveform');
    end
    y=y.*adsr_envelope;
       
    figure;
    clf;plot(y); title('Final Step');set(gca,'fontsize',18);
end
    

%% Binomial distribution, n tries, probability p
function r=binornd(n, p)
        r = sum(rand([1,n]) < p);

end