%% PLOT SPECTOGRAM OF THE INSTRUMENTS
close all;
clear all;

plot_spectrogram('Piano_mf_A4.wav', 5000);
plot_spectrogram('snare.wav', 10000);
plot_spectrogram('Trumpet_novib_A4.wav', 15000);

%% SYNTHESIZE PIANO
close all;
plot_spectrogram('Piano_mf_A4.wav', 5000);
% Based on the spectrogram, the pitch/fundamental freq
% is at 440Hz

[x, fs] = audioread('Piano_mf_A4.wav');
t = 0 : 1/fs : length(x)/fs;
ff = 440;   % fundamental frequency
amp = [1, 0.8, 0.6, 0.4, 0.2, 0.1];

% create the envelope
env = hilbert(x, length(t));
env = abs(env);
env = env ./ max(abs(env));
env = env';

[attack,delay,sustain,release,P,adsr_time] = getADSR(x, fs);
P = interp1(adsr_time, P, t);
P = P ./ max(P);

figure();
plot(t,P);

figure();
plot(t, env);
figure();
signal = zeros(length(x) + 1,1)';

for k = 1:6
    % create sine wave
    new_signal = sin(2*pi*(ff * k));
    % add envelope
    new_signal = new_signal .* env;
    % new_signal = new_signal .* P;
    
    signal = signal + new_signal;
end

signal = signal ./ max(abs(signal));

% add a high pass filter 
% [b,a] = butter(6, 4000 / fs, 'low');
% signal = filter(b,a,signal);
% [b,a] = butter(6, 100 / fs, 'high');
% signal = filter(b,a,signal);

spectrogram(signal, 256*4, [], 0:5000, fs, 'yaxis');

soundsc(x, fs);
pause(5);
soundsc(signal, fs);