%% PLOT SPECTOGRAM OF THE INSTRUMENTS
close all;
clear;

plot_spectrogram('Piano_mf_A4.wav', 5000);
plot_spectrogram('snare.wav', 10000);
plot_spectrogram('Trumpet_novib_A4.wav', 15000);

%% SYNTHESIZE PIANO
close all;
clear;

plot_spectrogram('Piano_mf_A4.wav', 5000);
% Based on the spectrogram, the pitch/fundamental freq
% is at 440Hz

[x, fs] = audioread('Piano_mf_A4.wav');
t = 0 : 1/fs : length(x)/fs;
ff = 440;   % fundamental frequency

% create the envelope
env = hilbert(x, length(t));
env = abs(env);
env = env ./ max(abs(env));
env = env';

[attack,delay,sustain,release,P,adsr_time] = getADSR(x, fs);
P = interp1(adsr_time, P, t);
P = P ./ max(P);

signal = zeros(length(x) + 1,1)';

for k = 1:6
    % create sine wave
    new_signal = sin(2*pi*(ff * k));
    % add envelope
    new_signal = new_signal .* env;
    % new_signal = new_signal .* P;
    
    signal = signal + new_signal;
end

% add filters to remove unnecessary frequencies
[b,a] = butter(2, 100 / fs, 'high');
signal = filter(b,a,signal);

signal = signal ./ max(abs(signal));

figure();
spectrogram(signal, power(2,10), [], 0:5000, fs, 'yaxis');

%% SYNTHESIZE SNARE

soundsc(x, fs);
pause(5);
soundsc(signal, fs);
[snare,snareFS] = audioread('snare.wav');

%% Extract ADSR params
[snareAttack, snareDecay, snareSustain, snareRelease] = getADSR(snare, snareFS);


%% Generate ADSR envelope
snareADSREnvelope = ADSRenvelope(snareAttack, snareDecay, snareSustain, snareRelease,0.1,8000);

%% Compate ADSR envelope with original envelope
