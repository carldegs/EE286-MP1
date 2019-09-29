%%
% ******* Constants and Other Parameters ******* %
fs = 44100; % sampling rate
N = 80000; % length of vector to compute
D = round(fs/580); % delay line (or wavetable) length

%% ******* Simple Filter (580 Hz) ******* %
F = [0 500 580 600 1000 2000 ];
A = [0.001 0.7 1 0 0 0];

b = firls(40, F*2./fs, A); 
a=1;

[H,W] = freqz(b, 1, 0:2000, fs);
Hmag=abs(H);
figure(1);
plot(W, mag2db(Hmag));
xlabel('Frequency (Hz)');
ylabel('Magnitude (dB)');
hold on;
plot(F,mag2db(A),'r--')
legend('firls design','Ideal');
grid on;
hold off;


%% ******* Initialize delay lines ******* %
y = zeros(1,N); % initialize output vector
dline = 2 * rand(1, D) - 1.0;
ptr = 1;
figure(2); subplot(3,1,1);plot(dline);set(gca,'fontsize',18);
title('Original delayline');
subplot(3,1,2);plot(dline);set(gca,'fontsize',18);
title('Filter delayline step n');


figure(2);
subplot(3,1,3); plot(y); title('Waveform Step n');set(gca,'fontsize',18);
%%
% ******* Run Loop Start ******* %
for n = 1:N
    y(n) = dline(ptr);
    z = rand(1,max(length(a),length(b))-1);
    [dline(ptr), z] = filter(b, 1, y(n),z);
    % Increment Pointers & Check Limits
    ptr = ptr + 1;
    if ptr > D
        ptr = 1;
    end
    
    if mod(n,2000) == 0
        subplot(3,1,2);plot(dline)
        str = sprintf('Filter delayline step %d',n);
        title(str);
        subplot(3,1,3); plot(y);
        str = sprintf('Waveform Step %d',n);
        title(str);
        figure(2);
    end
end
% Scale soundfile if necessary
if max(abs(y)) > 0.95
    y = y./(max(abs(y))+0.1);
    disp('Scaled waveform');
end

figure(3);clf;plot(y); title('Final Step');set(gca,'fontsize',18);
sound(y',fs);

    